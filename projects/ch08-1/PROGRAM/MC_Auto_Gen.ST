(* This is automatically generated file, don't modify it *)

CONFIGURATION axis_config
    VAR_GLOBAL
        Axis1: AXIS_REF;
    END_VAR
END_CONFIGURATION

FUNCTION MC_Init_Axis
    VAR_EXTERNAL
        Axis1: AXIS_REF;
    END_VAR

    Axis1 := mc_axis_create('Axis1');
    mc_axis_assign_servo(Axis1, mc_servo_new_DS402());

END_FUNCTION
