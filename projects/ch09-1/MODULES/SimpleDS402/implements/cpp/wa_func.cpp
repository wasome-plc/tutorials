#include "../../.MODULE/cpp/wa_interface.h"

#include "simple_servo.hpp"

void * mc_servo_new_SimpleDS402()
{
    SimpleServo * servo = new SimpleServo();
    return (void *) servo;
}

