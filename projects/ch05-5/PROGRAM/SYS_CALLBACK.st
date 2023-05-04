
(************* 系统回调函数 *************)

(*
PLC应用程序加载完成回调
注: 此阶段IO系统尚未就绪,读取IO变量无法获取实际值,
    写IO变量将延迟到开始运行时再输出到实际IO设备
返回值：
    true: 继续执行
    false: 停止运行
*)
FUNCTION ON_LOAD : BOOL
    ON_LOAD := TRUE;
END_FUNCTION

(*
PLC应用程序启动回调
参数:
    first_run: 是否首次运行
返回值:
    true: 继续执行
    false: 停止运行
*)
FUNCTION ON_START : BOOL
    VAR_INPUT
        first_run: BOOL;
    END_VAR

    ON_START := TRUE;
END_FUNCTION

(*
PLC停机回调函数
参数:
    reason: 停机原因编码
*)
FUNCTION ON_STOP
    VAR_INPUT
        reason: DINT;
    END_VAR

END_FUNCTION

(*
PLC运行异常回调
返回值:
    true: 忽略异常继续执行
    false: 停止运行
*)
FUNCTION ON_EXCEPTION : BOOL
    ON_EXCEPTION := FALSE;
END_FUNCTION


(************* IO故障回调函数 *************)

(*
IO读故障回调
参数:
    id: IO唯一标识
返回值:
    0: 进入停机状态
    1: 忽略本次故障
    2: 永久忽略该IO的故障
*)
FUNCTION ON_IO_READ_FAULT : DINT
    VAR_INPUT
        id: DINT;
    END_VAR

    VAR
        is_input : BOOL;
        prot_id : DINT;
        station_idx : DINT;
        io_idx : DINT;
    END_VAR

    (* 解析IO编码 *)
    DECODE_IO_ID(id := id,
                 is_input => is_input,
                 protocol_id => prot_id,
                 station_idx => station_idx,
                 io_idx => io_idx);

    ON_IO_READ_FAULT := 0;
END_FUNCTION

(*
IO写故障回调
参数:
    id: IO唯一标识
返回值:
    0: 进入停机状态
    1: 忽略本次故障
    2: 永久忽略该IO的故障
*)
FUNCTION ON_IO_WRITE_FAULT : DINT
    VAR_INPUT
        id: DINT;
    END_VAR

    VAR
        is_input : BOOL;
        prot_id : DINT;
        station_idx : DINT;
        io_idx : DINT;
    END_VAR

    (* 解析IO编码 *)
    DECODE_IO_ID(id := id,
                 is_input => is_input,
                 protocol_id => prot_id,
                 station_idx => station_idx,
                 io_idx => io_idx);

    ON_IO_WRITE_FAULT := 0;
END_FUNCTION

