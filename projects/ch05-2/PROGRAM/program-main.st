(* PROGRAM 中可以调用其他POU， 如功能块、函数等 *)

PROGRAM program_demo_all_pous

    VAR
        (* 功能块使用前需要实例化 *)
        bank: fb_data_bank;                          
        (* 即将支持: 嵌套结构的初始化， 其中temperatures数组初始化为[20, 40, 40, 40] *)
        // iot_data: STRUCT_ENV_DATA := (dtime:=T#1d2h3m4s, env: (humity:=2.0, state:=RUNNING, temperatures:=[20,3(40)]));                                                    
        iot_data: STRUCT_ENV_DATA := (dtime:=T#1d2h3m4s);
        num: LINT := 0;
        money: DINT := 0;
    END_VAR

    (* 功能块调用时， 可以直接将某些输出赋值给变量：例如num *)
    bank(n := g_num, data := iot_data, num=>num);    

    (* 功能块有数据记忆功能， 可以调用后将输出赋值给其他变量： 例如money *)
    money := bank.money;                             

    (* 打印log时， 各个参数的类型需要与对应的占位符类型一致 *)
    WA_LOG('num(%d) == %d, money=%d', num, func_sum_factorial(g_num) , money);
    
END_PROGRAM
