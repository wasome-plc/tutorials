(* control for ETHERCAT DM3E-556 SERVO *)
(* Refer to the https://gitee.com/idrm-iot/ethercat_dm3e/blob/master/MotorControl.py *)


FUNCTION EnableMotor : BOOL

    EnableMotor := FALSE;
    Reg_6040_control_word := 0;
    Reg_6060_modesel := 0;
    
      IF (Reg_6041_status AND INT#16#0250) = INT#16#0250  THEN
          Reg_6040_control_word := 16#0006;

      ELSIF (Reg_6041_status AND 16#0237) = 16#0237  THEN
          Reg_6040_control_word := 16#000F;
          EnableMotor :=  TRUE;
          Reg_6060_modesel := 8;

      ELSIF (Reg_6041_status AND 16#0233) = 16#0233  THEN
          Reg_6040_control_word := 16#000F;
          Reg_6060_modesel := 8;

      ELSIF (Reg_6041_status AND 16#0231) = 16#0231  THEN
          Reg_6040_control_word := 16#0007;

      ELSE
       Reg_6040_control_word := 128;
   
      END_IF;    

      RETURN;
END_FUNCTION


FUNCTION ZeroPosition : BOOL
    ZeroPosition := FALSE;
    Reg_6060_modesel := 6;
    
   IF mode_display <> 6 THEN
       RETURN ;
   END_IF;

   Reg_6040_control_word := 16#001F;

   IF (Reg_6041_status AND 16#637) = 16#637  THEN
       ZeroPosition := TRUE;
    END_IF

    RETURN;
   
END_FUNCTION

FUNCTION MotorTargetPosition : BOOL
VAR_INPUT
    position: DINT; (* Comment *)
    moving_mode: BOOL := TRUE;
END_VAR
    MotorTargetPosition := FALSE;
    Reg_6060_modesel := 8;
    target_position := position;

   IF mode_display <> 8 THEN
       RETURN ;
   END_IF;

  IF moving_mode THEN
      Reg_6040_control_word := 16#000F;
  ELSE
      Reg_6040_control_word := 16#004F;     
  END_IF;
  
   IF (Reg_6041_status AND 16#8637) = 16#8637  THEN
        IF moving_mode THEN
            Reg_6040_control_word := 16#001F;
        ELSE
            Reg_6040_control_word := 16#005F;     
        END_IF;
    ELSIF (Reg_6041_status AND 16#1637) = 16#1637 THEN
        MotorTargetPosition := TRUE;
        RETURN;
    END_IF
END_FUNCTION

PROGRAM PLC_PRG
VAR
    Moved_Zero_Pos: BOOL := FALSE; (* Comment *)
    Moved_Target_Pos: BOOL := FALSE;
    Enabled : BOOL := FALSE;
END_VAR
    WA_LOG('Reg_6041_status = %d (0X%X)', Reg_6041_status, Reg_6041_status);
    WA_LOG('Reg_6060_modesel = %d (0X%X)', Reg_6060_modesel, Reg_6060_modesel);
    WA_LOG('last_error = %d (0X%X)', last_error, last_error);
    WA_LOG('mode_display = %d (0X%X)', mode_display, mode_display);
    WA_LOG('slave_state = %d (0X%X)', slave_state, slave_state);

      IF NOT Enabled THEN
          Enabled := EnableMotor();
      END_IF

      IF Enabled THEN
        IF NOT Moved_Zero_Pos THEN
            Moved_Zero_Pos := ZeroPosition();
        ELSIF NOT Moved_Target_Pos THEN
            Moved_Target_Pos := MotorTargetPosition(position := 400000);
        ELSE
            WA_LOG('Already moved to target pos');
        END_IF;
      END_IF

      WA_LOG('Reg_6040_control_word = %d (0X%X)', Reg_6040_control_word, Reg_6040_control_word);    
END_PROGRAM
