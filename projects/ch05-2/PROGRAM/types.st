(* 有子范围的数据类型 *)
TYPE BYTE_WITH_RANGE :
    SINT(10..60) := 16#1A; (* 初始化为 0x1A *)
END_TYPE

(** 数组数据类型 *)
TYPE ARRAY_BYTES_WITH_RANGE :  
    ARRAY [0..3] OF BYTE_WITH_RANGE;
END_TYPE

(* 枚举类型的数据类型: 机器状态 *)
TYPE ENUM_STATE_MACHINE : (
        INIT,
        PREPARING,
        RUNNING,
        STOPPED
    ) ;
END_TYPE

(*结构化的数据类型: 环境参数*)
TYPE STRUCT_ENV : STRUCT
        temperatures : ARRAY_BYTES_WITH_RANGE; (* 将多个温度值限制在10-60的范围 *)
        humity : REAL;
        state : ENUM_STATE_MACHINE;        
    END_STRUCT ;
END_TYPE

(*嵌套结构化的数据类型*)
TYPE STRUCT_ENV_DATA : 
    STRUCT
        env : STRUCT_ENV;
        name : STRING := 'factory';
        dtime : TIME;
    END_STRUCT ;
END_TYPE

TYPE IOT_DATA : 
    STRUCT_ENV_DATA;
END_TYPE
