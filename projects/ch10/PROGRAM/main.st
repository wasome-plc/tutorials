
PROGRAM PLC_PRG
    VAR
        x0 AT %IW0 : INT;   (* x0 在输入区的第0字节，占16bit *)
        t0 AT %QW0 : INT;   (* t0 在输出区的第0字节，占16bit *)
        x1 AT %ID2 : DINT;  (* x1 在输入区的第2字节，占32bit *)
        t1 AT %QD2 : DINT;  (* t1 在输出区的第2字节，占32bit *)
        x2 AT %ID6 : REAL;  (* x2 在输入区的第6字节，占32bit *)
        t2 AT %QD6 : REAL;  (* t2 在输出区的第6字节，占32bit *)

        m_byte   AT %MB100 : BYTE;  (* m_byte 在M区的第100字节，占8bit *)
        m_word   AT %MW110 : WORD;  (* m_word 在M区的第110字节，占16bit *)
        m_dword  AT %MD120 : DWORD; (* m_dword 在M区的第120字节，占32bit *)
        m_lword  AT %ML130 : LWORD; (* m_lword 在M区的第130字节，占64bit *)
        m_sint   AT %MB140 : SINT;  (* m_sint 在M区的第140字节，占8bit *)
        m_int    AT %MW150 : INT;   (* m_int 在M区的第150字节，占16bit *)
        m_dint   AT %MD160 : DINT;  (* m_dint 在M区的第160字节，占32bit *)
        m_lint   AT %ML170 : LINT;  (* m_lint 在M区的第170字节，占64bit *)
        m_real   AT %MD180 : REAL;  (* m_real 在M区的第180字节，占32bit *)
        m_lreal  AT %ML190 : LREAL; (* m_lreal 在M区的第190字节，占64bit *)
    END_VAR

    (* 对输入区读取到的数据进行一定的运算后，写到输出区 *)
    t0 := x0 + 1;
    t1 := x1 - 1;
    t2 := x2;

    (* 向M区的各变量写入固定的值，通过“上位机”读到的值应该和这些值一致 *)
    m_byte := 127;
    m_word := 12345;
    m_dword := 888888;
    m_lword := 99999999999;
    m_sint := -128;
    m_int := -32768;
    m_dint := -2147483648;
    m_lint := -214748364888888;
    m_real := 3.14;
    m_lreal := LREAL#987654321.123;

END_PROGRAM
