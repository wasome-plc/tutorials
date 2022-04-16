(** 函数POU中也可以调用全局变量 *)
FUNCTION isGreaterThanGlobalVar : BOOL
    VAR_INPUT
        level: INT;
    END_VAR

    (* 全局变量的定义方式二： 在IDE的全局变量列表中定义， 例如这里的 g_var_config ， 使用时，也可以直接使用  *)
    IF level > g_var_config THEN
        isGreaterThanGlobalVar := TRUE;
    ELSE
        isGreaterThanGlobalVar := FALSE;
    END_IF;
    
END_FUNCTION
