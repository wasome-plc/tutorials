FUNCTION_BLOCK fb
    VAR_INPUT
        x: INT;
    END_VAR

    VAR_OUTPUT
        res: INT;
    END_VAR

    res := x + 1;
END_FUNCTION_BLOCK


FUNCTION_BLOCK fb2
    VAR_INPUT
        x: DINT;
    END_VAR

    VAR_OUTPUT
        res: DINT;
    END_VAR

    res := x - 1;
END_FUNCTION_BLOCK


PROGRAM PLC_PRG
    VAR
        f: fb;
        f1: fb2;
        x0 AT %IW0 : INT;
        t0 AT %QW0 : INT;
        x1 AT %ID2 : DINT;
        t1 AT %QD2 : DINT;
        x2 AT %ID6 : REAL;
        t2 AT %QD6 : REAL;

        INPUT10_0 AT %IX10.0: BOOL;
        INPUT10_1 AT %IX10.1: BOOL;
        INPUT10  AT %IB10: BYTE;
        OUTPUT10  AT %QB10: BYTE;
        OUTPUT11  AT %QB11: BYTE;

        OUTPUTS AT %QB12 : ARRAY[0..2] OF BYTE;
        INPUTS AT %IB12 : ARRAY[0..2] OF BYTE;

        i : INT := 0;
        cur : INT := -1;
        TEMP : BYTE;
        ERR_CNT AT %QW20 : INT := 1;
    END_VAR

    VAR_OUTPUT
        res: INT;
    END_VAR

    f(x := x0);
    t0 := f.res;

    f1(x := x1);
    t1 := f1.res;

    t2 := x2;

    TEMP := TO_BYTE(INPUT10_1) * 2 + INPUT10_0;
    WARNING('cur: %d, INPUT10:%d, INPUT10_1: %d', cur, INPUT10, TO_INT(INPUT10_1));

   IF TEMP <>  INPUT10 THEN
        ERR_CNT := ERR_CNT + 1;
        WA_LOG('TEMP: %d, INPUT10: %d$n',TO_INT(TEMP), TO_INT(INPUT10));       
   END_IF;
   

    IF cur = -1 THEN
        cur := 0;
    ELSE 
       IF TO_BYTE(INPUT10_0) <> OUTPUT10 OR TO_BYTE(INPUT10_1) <> OUTPUT11 THEN
           ERR_CNT := ERR_CNT + 1;
           WA_LOG('INPUT10: %d, OUTPUT10: %d$n',TO_INT(INPUT10), TO_INT(OUTPUT10));
       END_IF;
       
        FOR i:= 0 TO 3 DO
            IF INPUTS[i] <> OUTPUTS[i] THEN
                ERR_CNT := ERR_CNT + 1;
                WA_LOG('%d: INPUT: %d, OUTPUT: %d$n', i, TO_INT(INPUTS[i]), TO_INT(OUTPUTS[i]));
            END_IF
        END_FOR;
    END_IF;

    IF cur = 3 THEN
        cur := 0;
    END_IF;

   FOR i:= 0 TO 3 DO
       OUTPUTS[i]:= 0;
   END_FOR;
   OUTPUTS[cur] := 1;
   cur := cur + 1;

   OUTPUT10 := OUTPUTS[0];
   OUTPUT11 := OUTPUTS[1];

END_PROGRAM

CONFIGURATION configuration0

    RESOURCE res0 ON PLC
        TASK task0(INTERVAL := T#2000ms, PRIORITY := 1);
        PROGRAM instance1 WITH task0 : PLC_PRG;
    END_RESOURCE
END_CONFIGURATION
