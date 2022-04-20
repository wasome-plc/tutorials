(* 功能块中可以调用其他功能块、函数 *)

FUNCTION_BLOCK fb_data_bank

        (* 功能块的输入: n, data*)
        VAR_INPUT
            n: INT; (*  *)
            data: STRUCT_ENV_DATA;
        END_VAR

        (* 功能块的输出: num, money*)
        VAR_OUTPUT
            money: DINT := 0;
            num: LINT := 0;
        END_VAR

        (* 功能块的功能逻辑: 将输入data中的数据累加到money中， 将输入n做阶乘累加到num中 *)
        money := money + func_sum_array(data.env.temperatures);
        num := func_factorial(n);

END_FUNCTION_BLOCK
