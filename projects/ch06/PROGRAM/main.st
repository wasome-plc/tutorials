PROGRAM PLC_PRG
    VAR
        c_counter_inst : counter; (* C语言实现的counter示例 *)
        cpp_counter_inst : cpp_counter; (* C++语言实现的counter示例 *)
        st_counter_inst : st_counter; (* ST语言实现的counter示例 *)

        res1, res2, res3 : DINT := 0;
    END_VAR

    IF res1 < 1 THEN
        greeting_from_c('Hello PLC');
    END_IF;

    c_counter_inst(IN := 1, CNT => res1);
    cpp_counter_inst(IN := 1, CNT => res2);
    st_counter_inst(IN := 1, CNT => res3);

END_PROGRAM
