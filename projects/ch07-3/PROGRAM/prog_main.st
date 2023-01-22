FUNCTION GetControlWord : INT
VAR_INPUT
    status: INT;
END_VAR
VAR
    control_word: INT := 16#0080; (* Comment *)
END_VAR
    IF (status AND INT#16#004F) = 16#0 THEN
        control_word := 16#0080;
    ELSIF (status AND INT#16#004F) = 16#40 THEN
        control_word := 16#0006;
    ELSIF (status AND INT#16#006F) = 16#21 THEN
        control_word := 16#0007;
    ELSIF (status AND INT#16#006F) = 16#23 THEN
        control_word := 16#000F;
    ELSIF (status AND INT#16#006F) = 16#27 THEN
        control_word := 16#001F;
    ELSIF (status AND INT#16#006F) = 16#07 THEN
        control_word := 16#0000;
    ELSIF (status AND INT#16#004F) = 16#0F THEN
        control_word := 16#0080;
    ELSIF (status AND INT#16#004F) = 16#08 THEN
        control_word := 16#0080;
    ELSE
        control_word := 16#0080;
    END_IF;

    GetControlWord := control_word;

END_FUNCTION

PROGRAM PLC_PRG
    VAR
        target_position: DINT := 0;
        target_vel: DINT := 16#1000000;
        cnt : INT := 0;
    END_VAR

      //target_position := Reg_6064_actual_pos + 255;
      //Reg_60ff_target_vel := 16#1000000;
      //Reg_6040_control_word := 0;

      WA_LOG('Reg_6041_status = %d (0X%X), act-pos=%d (0X%X)', Reg_6041_status, Reg_6041_status, Reg_6064_actual_pos, Reg_6064_actual_pos);

      //Reg_6040_control_word := GetControlWord(Reg_6041_status);
      //Reg_6060_modesel := 9;


      target_position := Reg_6064_actual_pos + 255;
      Reg_60ff_target_vel := 0;
      Reg_6040_control_word := 0;
      Reg_60ff_target_vel := 16#1000000 (*target_vel*);

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
          Reg_60ff_target_vel := 16#1000000 (*target_vel*);
          Reg_6040_control_word := 16#001F;
      END_IF;

      

      WA_LOG('Reg_6060_modesel = %d (0X%X)', Reg_6060_modesel, Reg_6060_modesel);
      WA_LOG('Reg_6040_control_word = %d (0X%X)', Reg_6040_control_word, Reg_6040_control_word);
      WA_LOG('Reg_60ff_target_vel = %d (0X%X) $n', Reg_60ff_target_vel, Reg_60ff_target_vel);
END_PROGRAM
