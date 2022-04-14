PROGRAM program_demo_all_pous

    VAR
        bank: fb_data_bank; (* Comment *)
        iot_data: STRUCT_ENV_DATA;

        num: LINT := 0;
        money: DINT := 0;
    END_VAR

    bank(n := g_num, data := iot_data, num=>num);
    money := bank.money;
    
END_PROGRAM