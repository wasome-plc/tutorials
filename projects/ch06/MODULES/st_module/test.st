
FUNCTION_BLOCK st_counter
    VAR_INPUT
        IN: DINT := 0;
    END_VAR

    VAR_OUTPUT
        CNT: DINT := 0;
    END_VAR

    CNT := CNT + IN;
END_FUNCTION_BLOCK
