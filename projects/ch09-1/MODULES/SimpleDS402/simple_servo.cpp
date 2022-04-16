
#include <simple_servo.hpp>

#include <stdio.h>
#include <string.h>
#include <errno.h>
#include <mqueue.h>
#include <stdlib.h>
#include <stdbool.h>
#include <unistd.h>
#include <limits.h>
#include <sys/types.h>
#include <sys/time.h>
#include <time.h>
#include <getopt.h>
#include <cmath>

#define SERVO_LOG printf


class SimpleServo::ServoImpl
{
public:
  int32_t mSubmitPos = 0;
  int32_t mPos = 0;
  double mVel = 0;
  double mAcc = 0;
};

SimpleServo::SimpleServo()
: mImpl_(NULL),
  mode_(MODE_CSP),
  ethercat_config_done_(false),
  servo_on_(false),
  power_status_(false),
  power_state_(0),
  drive_number_(0),
  target_(0),
  set_tar_vel_(0)
{
  mImpl_ = new ServoImpl();
  controlword_ = 0;
  statusword_ = 0;
  targetpos_ = 0;
  actualpos_ = 0;
  modesel_ = 0;
  targetvel_ = 0;
}

SimpleServo::~SimpleServo()
{
    delete mImpl_;
}

void SimpleServo::initialize()
{
    ethercat_config_done_ = true;
}

bool isServoError(uint16_t status)
{
  return ((status & 0x004F) == 0x000F) || ((status & 0x004F) == 0x0008);
}

MC_ServoErrorCode SimpleServo::setPower(bool powerStatus, bool& isDone)
{
  MC_ServoErrorCode result = Servo_No_Error;
  isDone = false;

  if (powerStatus && !power_status_) // Enable Power On --> 100
  {
    if (!ethercat_config_done_)
      return Servo_Fieldbus_Init_Error;

    power_state_ = 100;
    SERVO_LOG("drive:%d Enable Power On\n", drive_number_);
  }
  else if (power_status_ && !powerStatus) // Enable Power Off --> 200
  {
    servo_on_ = false;
    power_state_ = 200;
    SERVO_LOG("drive:%d Enable Power Off\n", drive_number_);
  }
  else
  {
    if (power_state_ == 100) // When enable power on
    {
      if ((status_ & 0x007F) == 0x0037)  // Operation Enabled --> 101
      {
        isDone = true;
        servo_on_ = true;
        power_state_ = 101;
        SERVO_LOG("drive:%d Power up\n", drive_number_);
      }
      else if ((status_ & 0x006F) == 0x0007) // FSA State: Quick Stop Active
      {
        control_ =  0x00;
        SERVO_LOG("drive:%d Drive Quick Stop Active\n", drive_number_);
      }
      else if ((status_ & 0x4F) == 0x0) // FSA State: Not ready to Switch on
      {
        control_ = 0x80;
        SERVO_LOG("drive:%d Not ready to Switch on\n", drive_number_);
      }
      else if((status_ & 0x004F) == 0x0040) // FSA State: Switch On Disabled
      {
        control_ = 0x06;
        SERVO_LOG("drive:%d Switch On Disabled\n", drive_number_);
      }
      else if ((status_ & 0x007F) == 0x0031)  // FSA State: Ready to Switch On
      {
        control_ = 0x07;
        SERVO_LOG("drive:%d Ready to Switch On\n", drive_number_);
      }
      else if ((status_ & 0x007B) == 0x0033)  // FSA State: Switched On
      {
        mImpl_->mPos = read_reg_U32(Reg_6064_actual_pos);
        write_reg_U32(Reg_607a_target_pos, mImpl_->mPos);
        write_reg_U8(Reg_6060_modesel, MODE_CSP);
        control_ = 0x0F;
        SERVO_LOG("drive:%d Switch on\n", drive_number_);
      }
      else if ((status_ & 0x4F) == 0x0F) // Fault reaction active
      {
        control_ = 0x80;
        SERVO_LOG("drive:%d Fault reaction active\n", drive_number_);
      } 
      else if ((status_ & 0x4F) == 0x08) // Fault
      {
        control_ = 0x80;
        SERVO_LOG("drive:%d Fault\n", drive_number_);
      }
   	  else
      {
        servo_on_ = false;
        isDone = false;
        power_state_ = 300;
        result = Servo_Powering_On_Error;
        SERVO_LOG("drive:%d Error, Power On statusword=0x%X\n", drive_number_, status_);
      }
    }
    else if (power_state_ == 101) // When powered on
    {
      if (isServoError(status_))
      {
        servo_on_ = false;
        isDone = false;
        power_state_ = 300;
        result = Servo_Error_When_Powered_On;
        SERVO_LOG("drive:%d Error, Powered On\n", drive_number_);
      }
      else
      {
    	  isDone = true;
      }
    }
    else if (power_state_ == 200) // When enabled power off --> 201
    {
      control_ = 0x06;
      power_state_ = 201;
    }
    else if (power_state_ == 201) // After sending shut down message
    {
      control_ = 0x06;
      if (isServoError(status_)) // Shut down fail
      {
        servo_on_ = false;
        isDone = false;
        result = Servo_Powering_Off_Error;
        SERVO_LOG("drive:%d Drive Error, Power off\n", drive_number_);
      }
      else
      {
        if ((status_ & 0x007F) == 0x0031) // Shut down to: Ready to Switch On
        {
          servo_on_ = false;
          isDone = true;
          power_state_ = 0;
          SERVO_LOG("drive:%d Drive, Power off\n", drive_number_);
        }
      }
    }
  }

  power_status_ = powerStatus;
  return result;
}

MC_ServoErrorCode SimpleServo::resetError(bool& isDone)
{
  MC_ServoErrorCode result = Servo_No_Error;
  isDone = false;

  //  SERVO_LOG("drive:%d *statusword_: 0x%X, power_state_: %d\n", drive_number_, status, power_state_);
  if (power_state_ == 300)
  {
    if (isServoError(status_))
    {
      control_ = 0x80;
    }
    else if ((status_ & 0x004F) == 0x0040)
    {
      power_state_ = 0;
      isDone = true;
    }
  }
  else
  {
    power_state_ = 0;
    isDone = true;
  }

  return result;
}

MC_ServoErrorCode SimpleServo::setPos(int32_t pos)
{
    mImpl_->mSubmitPos = pos;
    return 0;
}

MC_ServoErrorCode SimpleServo::setVel(int32_t vel)
{
    set_tar_vel_ = vel;
    // SERVO_LOG("set_tar_vel: %d\n", set_tar_vel_);
    return 0;
}

int32_t SimpleServo::pos(void)
{
    return mImpl_->mPos;
}

int32_t SimpleServo::vel(void)
{
    return mImpl_->mVel;
}

void SimpleServo::runCycle(double freq)
{
  status_ = read_reg_U16(Reg_6041_status);
  SERVO_LOG("drive:%d *statusword_: 0x%X, power_state_: %d\n", drive_number_, status_, power_state_);
  if (ethercat_config_done_)
  {
    target_ = read_reg_U32(Reg_6064_actual_pos);
    double curVel = ((int32_t)target_ - mImpl_->mPos) * freq;
    mImpl_->mAcc = (curVel - mImpl_->mVel) * freq;
    mImpl_->mVel = curVel;
    mImpl_->mPos = target_;
    if (servo_on_)
    {
      switch (mode_)
      {
        case MODE_CSP:
        {
          target_ = mImpl_->mSubmitPos;
          write_reg_U32(Reg_607a_target_pos, target_);
          write_reg_U8(Reg_6060_modesel, MODE_CSP);
          break;
        }
        case MODE_CSV:
        {
          write_reg_U32(Reg_60ff_target_vel, set_tar_vel_);
          write_reg_U8(Reg_6060_modesel, MODE_CSV);
          break;
        }
        default:
        break;
      }
    }
  }
  write_reg_U16(Reg_6040_control_word, control_);
}
