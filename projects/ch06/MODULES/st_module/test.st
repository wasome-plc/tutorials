
FUNCTION_BLOCK st_counter
    VAR_INPUT
        IN1: DINT := 0;
    END_VAR

    VAR_OUTPUT
        CNT: DINT := 0;
    END_VAR

    CNT := CNT + IN1;
END_FUNCTION_BLOCK
