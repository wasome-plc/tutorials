(* PROGRAM 中可以调用其他POU， 如功能块、函数等 *)

PROGRAM program_demo_all_pous

    VAR
        bank: fb_data_bank;                          (* 功能块使用前需要实例化 *)
        // iot_data: STRUCT_ENV_DATA := (dtime:=T#1d2h3m4s, env: (humity:=2.0, state:=RUNNING, temperatures:=[20,3(40)]));
                                                     (* 结构型数据类型的变量初始化， 其中temperatures数组初始化为[20, 40, 40, 40] *)
        iot_data: STRUCT_ENV_DATA := (dtime := T#3m, env: (humity := 2.0, state := RUNNING, temperatures := [20,3(40)]));
        num: LINT := 0;
        money: DINT := 0;
    END_VAR

    bank(n := g_num, data := iot_data, num=>num);    (* 功能块调用时， 可以直接将某些输出赋值给变量：例如num *)
    money := bank.money;                             (* 功能块有数据记忆功能， 可以调用后将输出赋值给其他变量： 例如money *)

    WA_LOG('num(%d) == %d, money=%d', num,  , money);(* 打印log时， 各个参数的类型需要与对应的占位符类型一致 *)
    
END_PROGRAM
