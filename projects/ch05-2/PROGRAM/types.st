(* 自定义数据类型 *)

(* 数据类型: 有初始化的值 *)
TYPE BYTE_WITH_RANGE :
    SINT := 16#1A; (* 初始化为 0x1A *)
END_TYPE

(** 数据类型: 数组 *)
TYPE ARRAY_BYTES_WITH_RANGE :  
    ARRAY [0..3] OF BYTE_WITH_RANGE;
END_TYPE

(* 数据类型: 枚举 *)
TYPE ENUM_STATE_MACHINE : (
        INIT,
        PREPARING,
        RUNNING,
        STOPPED
    ) ;
END_TYPE

(* 数据类型: 结构 *)
TYPE STRUCT_ENV : STRUCT
        temperatures : ARRAY_BYTES_WITH_RANGE; 
        humity : REAL;
        state : ENUM_STATE_MACHINE;        
    END_STRUCT ;
END_TYPE

(* 数据类型: 嵌套结构 *)
TYPE STRUCT_ENV_DATA : 
    STRUCT
        env : STRUCT_ENV;
        dtime : TIME;
    END_STRUCT ;
END_TYPE

(* 数据类型: 结构重命名 *)
TYPE IOT_DATA : 
    STRUCT_ENV_DATA;
END_TYPE
