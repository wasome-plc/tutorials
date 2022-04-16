PROGRAM PLC_PRG
    VAR
        // INPUT10_0与INPUT10_1对应modbus寄存器10, 11
        INPUT10_0 AT %IX10.0: BOOL;
        INPUT10_1 AT %IX10.1: BOOL;
        INPUT10  AT %IB10: BYTE;

        // OUTPUT10与OUTPUT11的数值写入modbus寄存器10, 11
        OUTPUT10  AT %QB10: BYTE;
        OUTPUT11  AT %QB11: BYTE;

        // INPUTS [0..2]对应modbus寄存器12,13,14读入数值
        // OUTPUTS[0..2]对应要写入modbus寄存器12,13,14的数值
        OUTPUTS AT %QB12 : ARRAY[0..2] OF BYTE;
        INPUTS AT %IB12 : ARRAY[0..2] OF BYTE;

        // ERR_CNT: 对应modbus寄存器20, 用来输出错误计数
        ERR_CNT AT %QW20 : INT := 1;

        i : INT := 0;
        cur : INT := -1;
        TEMP : BYTE;
    END_VAR

    VAR_OUTPUT
        res: INT;
    END_VAR

    // x0, x1, x2：在IO表中配置的INPUT地址全局变量，对应modbus寄存器1, 2, 4
    // t0, t1, t2：在IO表中配置的OUTPUT地址全局变量，对应modbus寄存器100, 101, 103
    // 在IO表中以上变量的IO内存位置设置为“自动”，由IDE自动分配
    
    // 测试python会写入modbus寄存器1, 2, 4，然后读取modbus寄存器100, 101, 103
    // 使用读取的数值对比写入的数值来验证ST在工作正常
  
    // 设置t0为x0+1
    t0 := x0 + 1;

    // 设置t1为x1-1
    t1 := x1 - 1;

    // 设置t2等于x2
    t2 := x2;

    // 验证：INPUT10_0与INPUT10_1是INPUT10字节的第0和1个比特
    TEMP := TO_BYTE(INPUT10_1) * 2 + INPUT10_0;
    WARNING('cur: %d, INPUT10:%d, INPUT10_1: %d', cur, INPUT10, TO_INT(INPUT10_1));
    IF TEMP <>  INPUT10 THEN
        ERR_CNT := ERR_CNT + 1;
        WA_LOG('TEMP: %d, INPUT10: %d$n',TO_INT(TEMP), TO_INT(INPUT10));       
    END_IF;
   
    // 忽略第一个周期
    IF cur = -1 THEN
        cur := 0;
    ELSE 
        // 验证在modbus寄存器10, 11本周期读入的值等于上周期写入的值
        IF TO_BYTE(INPUT10_0) <> OUTPUT10 OR TO_BYTE(INPUT10_1) <> OUTPUT11 THEN
           ERR_CNT := ERR_CNT + 1;
           WA_LOG('INPUT10: %d, OUTPUT10: %d$n',TO_INT(INPUT10), TO_INT(OUTPUT10));
        END_IF;
       
        // 验证在modbus寄存器12..14本周期读出来的值等于上周期写入的值
        FOR i:= 0 TO 3 DO
            IF INPUTS[i] <> OUTPUTS[i] THEN
                ERR_CNT := ERR_CNT + 1;
                WA_LOG('%d: INPUT: %d, OUTPUT: %d$n', i, TO_INT(INPUTS[i]), TO_INT(OUTPUTS[i]));
            END_IF
        END_FOR;
    END_IF;

    // 对于modbus寄存器12..14进行跑马灯写值
    IF cur = 3 THEN
        cur := 0;
    END_IF;
   FOR i:= 0 TO 3 DO
       OUTPUTS[i]:= 0;
   END_FOR;
   OUTPUTS[cur] := 1;
   cur := cur + 1;

    //modbus寄存器10，11写入与寄存器12，13相同的值
   OUTPUT10 := OUTPUTS[0];
   OUTPUT11 := OUTPUTS[1];
END_PROGRAM

CONFIGURATION configuration0

    RESOURCE res0 ON PLC
        TASK task0(INTERVAL := T#2000ms, PRIORITY := 1);
        PROGRAM instance1 WITH task0 : PLC_PRG;
    END_RESOURCE
END_CONFIGURATION
