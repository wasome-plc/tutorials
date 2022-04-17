PROGRAM PLC_PRG
    VAR
        fbPower: MC_Power; (* 定义功能块实例 *)
    END_VAR

    fbPower(Axis := Axis1, Enable := TRUE, EnablePositive := TRUE, EnableNegative := TRUE);

END_PROGRAM
