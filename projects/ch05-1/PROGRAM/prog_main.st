(* 本APP展示基本变量定义、赋值、使用； 表达式、基本流程语句的用法 *)

PROGRAM PLC_PRG
VAR
    b: BOOL;         (**BOOL类型的变量定义*)
    n: INT := 10;    (*初始化为10*)
    r: REAL := 1.2;
    s: SINT;
    d: ARRAY[0..2] OF DINT;      (*定义长度为3的一维数组*)
END_VAR

    b := convertToBOOL(n);       (*调用函数并将返回值赋给变量b*)
    s := convertToSINT(TO_DINT(r));
    d[0] := getSumWithFor(s);     (*使用for语句实现的函数*)
    d[1] := getSumWithWhile(s);   (*使用while语句实现的函数*)
    d[2] := getSumWithRepeat(s);  (*使用repeat语句实现的函数*)

    WA_LOG('g_iVar1=%d, g_iVar2=%d, g_bVar=%d, g_fVar1=%f, g_sVar=%s', 
        g_iVar1, g_iVar2, TO_INT(g_bVar), g_fVar1, g_sVar);

    g_fVar1 := g_fVar1 + 0.1;
 
END_PROGRAM


/// *****************
(** 使用IF ELSE 语句将INT转换为BOOL *)
/// *****************
FUNCTION convertToBOOL : BOOL
    VAR_INPUT level: INT; END_VAR
    IF level > 10 THEN
        convertToBOOL := TRUE;
    ELSIF level >= 5  THEN
        convertToBOOL := FALSE;
    ELSE
        convertToBOOL := TRUE;
    END_IF;
END_FUNCTION

/// *****************
(** 使用CASE选择语句将DINT转换为SINT *)
/// *****************
FUNCTION convertToSINT : SINT
    VAR_INPUT level: DINT; END_VAR
    VAR ret: SINT; END_VAR
    CASE level OF
        0, 1, 2: ret := 1;  (* 当level为0或1或2时 ，将ret设为1 *)
        3: ret := 2;
    ELSE
        ret := 3;
    END_CASE;    
    convertToSINT := ret;        
END_FUNCTION

// /// *****************
// (** 使用for循环语句计算1+...+n *)
// /// *****************
FUNCTION getSumWithFor : DINT
    VAR_INPUT n: SINT; END_VAR
    VAR i: SINT; sum: DINT := 0; END_VAR

    FOR i:=1 TO n BY 1 DO
        sum := sum + i;
    END_FOR;
    getSumWithFor := sum;
END_FUNCTION


// /// *****************
// (**  使用while循环语句计算1+...+n  *)
// /// *****************
FUNCTION getSumWithWhile : DINT
    VAR_INPUT n: SINT; END_VAR
    VAR 
        i: SINT; 
        sum: DINT := 0; 
    END_VAR

    i := 1;
    WHILE i <= n DO
        sum := sum + i;
        i := i + 1;
    END_WHILE;
    getSumWithWhile := sum;
END_FUNCTION


/// *****************
(**  使用repeat循环语句计算1+...+n  *)
/// *****************
FUNCTION getSumWithRepeat : DINT
    VAR_INPUT n: SINT; END_VAR
    VAR i: SINT; sum: DINT := 0; END_VAR

    i := 1;
    REPEAT
        sum := sum + i;
        i := i + 1;
    UNTIL i <= n
    END_REPEAT;
    getSumWithRepeat := sum;
END_FUNCTION
