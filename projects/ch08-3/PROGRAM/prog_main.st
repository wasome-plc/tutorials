PROGRAM PLC_PRG
    VAR
        Reg_6041_status AT %IW1000 : INT;
        Reg_6064_actual_pos AT %ID1002 : DINT;

        Reg_6040_control_word AT %QW1000 : INT;
        Reg_607a_target_pos AT %QD1002 : DINT;
        Reg_6060_modesel AT %QB1006 : SINT;
        Reg_60ff_target_vel AT %QD1008 : DINT;

        target_position: DINT := 0;
        target_vel: DINT := 16#1000000;
        cnt : INT := 0;
    END_VAR

      target_position := Reg_6064_actual_pos + 255;
      Reg_60ff_target_vel := 0;
      Reg_6040_control_word := 0;

      IF Reg_6041_status = 16#218 THEN
          Reg_6040_control_word := 16#0080;

      ELSIF (Reg_6041_status AND INT#16#004F) = INT#16#0040  THEN
          Reg_6040_control_word := 16#0006;

      ELSIF (Reg_6041_status AND 16#006F) = 16#0021  THEN
          Reg_6040_control_word := 16#0007;

      ELSIF (Reg_6041_status AND 16#006F) = 16#0023  THEN
          Reg_6060_modesel := 9;
          Reg_6040_control_word := 16#000F;

      ELSIF (Reg_6041_status AND 16#006F) = 16#0027  THEN
          cnt := cnt + 1;
          IF cnt > 20 THEN
              cnt := 0;
              IF target_vel = 0 THEN
                target_vel := 16#1000000;
              ELSE
                target_vel := 0;
              END_IF;
          END_IF;
          Reg_60ff_target_vel := target_vel;
          Reg_6040_control_word := 16#001F;
      END_IF;

      

END_PROGRAM

CONFIGURATION configuration0

    RESOURCE res0 ON PLC
        TASK task0(INTERVAL := T#10ms, PRIORITY := 1);
        PROGRAM instance1 WITH task0 : PLC_PRG;
    END_RESOURCE
END_CONFIGURATION
