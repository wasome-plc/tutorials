FUNCTION_BLOCK fb_data_bank
        VAR_INPUT
            n: SINT; (*  *)
            data: STRUCT_ENV_DATA;
        END_VAR

        VAR_OUTPUT
            money: DINT := 0;
            num: LINT := 0;
        END_VAR

        money := money + func_sum_array(data.env.temperatures);
        num := num + func_sum_factorial(n);

END_FUNCTION_BLOCK