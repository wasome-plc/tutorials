PROGRAM PLC_PRG
    VAR
        fbPower: MC_Power; (* 定义功能块实例 *)
        fbHome: MC_Home;
        fbMoveVel: MC_MoveVelocity;
        fbStop: MC_Stop;
        power_valid: BOOL;
    END_VAR

    fbPower(Axis := Axis1, Enable := TRUE, EnablePositive := TRUE, EnableNegative := TRUE, Valid => power_valid);
    IF NOT fbPower.Status THEN
       RETURN;
    END_IF;

    // fbHome(Axis := Axis1, Execute := TRUE, Position := 0, BufferMode := 0 /*mcAborting*/);

    fbMoveVel(Axis := Axis1, Execute := fbPower.Status, ContinuousUpdate:= TRUE, Velocity:=1,Acceleration:=50,Deceleration:=10,Jerk:=10);

    // fbStop(Axis := Axis1, Execute := fbMoveVel.InVelocity);

END_PROGRAM
