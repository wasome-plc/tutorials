FUNCTION func_sum_factorial : INT  (* 阶乘之和: 1!+2!+...+n! *)
    VAR_INPUT n: SINT; END_VAR

    VAR
        x: SINT;  
        sum: INT := 0;
    END_VAR

    FOR x := 1 TO n DO
        sum := sum + func_factorial(x); (* 函数function调用function *)
    END_FOR;

    func_sum_factorial := sum;
END_FUNCTION

FUNCTION func_factorial : INT  (* n阶乘 !n 之和 *)
    VAR_INPUT n: SINT; END_VAR

    VAR
        x: SINT; sum: INT := 1; 
    END_VAR

    FOR x := 1 TO n DO
        sum := sum*x;
    END_FOR;
    
    func_factorial := sum;
END_FUNCTION

FUNCTION func_sum_array : INT
    VAR_INPUT arrays: ARRAY_BYTES_WITH_RANGE; END_VAR
    VAR i: SINT; sum :INT :=0; END_VAR

    FOR i := 0 TO 3 BY 1 DO
        IF arrays[i] > 20 THEN
            sum := sum + 2;
        ELSE
            sum := sum + 1;
        END_IF;
    END_FOR;    

    func_sum_array := sum;
END_FUNCTION