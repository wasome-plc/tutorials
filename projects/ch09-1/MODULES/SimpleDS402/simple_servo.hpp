
#pragma once

#include <cstdint>
#include <cstddef>

#include "plc-base/.MODULE/cpp/servo_base.hpp"

#ifdef RTMOTION
using namespace RTmotion;
#endif

typedef uint32_t MC_ServoErrorCode;

#pragma pack(push)
#pragma pack(4)

class SimpleServo : public Servo
{
public:
  SimpleServo();
  virtual ~SimpleServo();

  enum {
    // input regsion
    Reg_6041_status = 0,
    Reg_6064_actual_pos = 2,

    // output region
    Reg_6040_control_word = 0,
    Reg_607a_target_pos = 2,
    Reg_6060_modesel = 6,
    Reg_60ff_target_vel = 8,
  };


  enum{
      MODE_PP		= 1,
      MODE_PV		= 3,
      MODE_PT		= 4,
      MODE_NULL	= 5,
      MODE_HM		= 6,
      MODE_IP		= 7,
      MODE_CSP	= 8,
      MODE_CSV	= 9,
      MODE_CST	= 10
  };
  
  virtual MC_ServoErrorCode setPower(bool powerStatus, bool& isDone) override;
  virtual MC_ServoErrorCode resetError(bool& isDone) override;
  virtual MC_ServoErrorCode setPos(int32_t pos) override;
  virtual MC_ServoErrorCode setVel(int32_t vel) override;
  virtual int32_t vel(void) override;
  virtual int32_t pos(void) override;
  virtual void runCycle(double freq) override;
  virtual void initialize() override;

  void setMode(uint8_t mode)
  { 
    mode_ = mode;
  }

    
private:

  class ServoImpl;
  ServoImpl* mImpl_;

  uint8_t mode_;
  bool ethercat_config_done_;

  bool servo_on_;
  bool power_status_;
  uint16_t power_state_;
  uint16_t drive_number_;

  uint16_t status_;
  uint16_t control_;
  uint32_t target_;

  int set_tar_vel_;

  uint32_t controlword_;
  uint32_t targetpos_;
  uint32_t statusword_;
  uint32_t actualpos_;
  uint32_t modesel_;
  uint32_t targetvel_;
};

#pragma pack(pop)
