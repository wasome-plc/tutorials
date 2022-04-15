PROGRAM program_demo_all_pous

    VAR
        bank: fb_data_bank; (* Comment *)
        // iot_data: STRUCT_ENV_DATA := (dtime:=T#1D2H3M4S, env: (humity:=2.0, state:=RUNNING, temperatures:=[20,3(40)]));
        iot_data: STRUCT_ENV_DATA := (dtime := T#3m, env: (humity := 2.0, state := RUNNING, temperatures := [20,3(40)]));
        num: LINT := 0;
        money: DINT := 0;
    END_VAR

    bank(n := g_num, data := iot_data, num=>num);
    money := bank.money;

    WA_LOG('num=%d money=%d', num, money);
    
END_PROGRAM