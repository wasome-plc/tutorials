FUNCTION_BLOCK fbd_test_1
    VAR_INPUT
        I0_1:BOOL;
    END_VAR
    VAR_OUTPUT
        I0:BOOL;
        M:BOOL;
    END_VAR
    VAR_TEMP
        __R0:BOOL;
    END_VAR
  IF I0_1=0  THEN
    I0:=1;
    M:= I0_1 AND I0;
  ELSIF I0_1= 1 THEN
      I0:=1;
      __R0:= I0_1 AND I0;
      M:=__R0 OR M;
      
  END_IF;
END_FUNCTION_BLOCK

FUNCTION_BLOCK fbd_test_2
    VAR_INPUT
        I0:BOOL;
        M:BOOL;
    END_VAR
    VAR_OUTPUT
        Q_1:BOOL;
    END_VAR
    VAR_TEMP
        I0_3:BOOL:=1;//
    END_VAR
  IF I0=0 AND M=0 THEN
      Q_1:=0;
  ELSIF I0=0 AND M=1 THEN
      Q_1:=0;
    ELSIF I0=1 AND M=1 THEN
        Q_1:=1;
       IF Q_1=1 THEN
           I0_3:=0;
       END_IF;
  END_IF;
END_FUNCTION_BLOCK