(* ST程序文件中可以同时定义多个POU： PROGRAM、 FUNCTION、 FUNCTION_BLOCK , 也可以定义多个配置： CONFIGURATION *)

PROGRAM PLC_PRG1

    (* 全局变量可以在使用前显示声明 *)
    VAR_EXTERNAL
        g_var_in_program: BOOL; 
    END_VAR

    g_var_in_program := NOT g_var_in_program;
    WA_LOG('g_var_in_program is changed to %d in PROGRAM PLC_PRG1', g_var_in_program );

END_PROGRAM

PROGRAM PLC_PRG2

    (* 全局变量也可以直接使用 *)
    g_var_in_program := isGreaterThanGlobalVar(20);
    WA_LOG('g_var_in_program is changed to %d in PROGRAM PLC_PRG2', g_var_in_program );
END_PROGRAM




(* 理论上可以定义多个CONFIGURATION，通常一个就可以 *)
CONFIGURATION config_0

    (* 全局变量的定义方式一：在ST程序文件中定义 *)
    VAR_GLOBAL
        g_var_in_program: BOOL := TRUE; (* Comment *)
    END_VAR

    (* 资源里的所有任务在一个CPU中运行 *)
    RESOURCE res0 ON PLC
        (* 可以定义不同优先级和周期的多个任务 *)
        TASK task1(INTERVAL := T#1ms, PRIORITY := 1);
        TASK task2(INTERVAL := T#100ms, PRIORITY := 5);

        (* 将不同的POU按照不同的任务配置来运行 *)
        PROGRAM instance1 WITH task1 : PLC_PRG1;
        PROGRAM instance2 WITH task2 : PLC_PRG2;
    END_RESOURCE
END_CONFIGURATION
