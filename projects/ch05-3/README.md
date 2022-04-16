# 概述

该项目展示了全局变量的定义方式、使用过程以及在ST程序中定义配置(CONFIGURATION)、资源(RESOURCE)、任务(TASK)等等。

# 全局变量

## 定义
全局变量属于一种全局资源，不属于任何POU， 包括 PROGRAM、FUNCTION_BLOCK、FUNCTION， 因此不能定义在POU中。

- 在ST程序的CONFIGURATION中定义
  ```
    VAR_GLOBAL
        g_var_in_program: BOOL := TRUE;
    END_VAR
  ```
- 在全局变量表中定义


## 使用
  在POU中使用时， 可以显示的声明，也可以直接使用。

  - 显示声明
  ```
    VAR_EXTERNAL
        g_var_in_program: BOOL; 
    END_VAR
  ```

  - 直接使用
  

# 资源与任务
  资源与任务是一种配置， 可以与POU平行定义在ST程序文件中。

  配置、资源与任务 的包含关系如下：

  ```
  CONFIGURATION config_0
      RESOURCE res0 ON PLC
          TASK task1(INTERVAL := T#1ms, PRIORITY := 1);
          TASK task2(INTERVAL := T#100ms, PRIORITY := 5);

          PROGRAM instance1 WITH task1 : PLC_PRG1;
          PROGRAM instance2 WITH task2 : PLC_PRG2;
      END_RESOURCE
  END_CONFIGURATION

  ```

