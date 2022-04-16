# chapter 8-2, 通过MODBUS控制示例

## 测试程序 (modbus_test.py)
测试内容：
- 进程存在
- bus已经open
- COAP查询plc状态
- 测试程序向plc app读取的寄存器随机写入MODBUS数据，然后读取plc app的写寄存器，检查在特定时间内，数据是否满足期望。



## 1: 双字节和四字节整数的访问
输入：
```
        x0 AT %IW0 : INT;
        x1 AT %ID2 : DINT;

        {
            "location": 0,
            "type": "INT",
            "num" :  1,
            "access": "coap://127.0.0.1:5683/mb/bus-1/1/1"
        },
        {
            "location": 2,
            "type": "DINT",
            "num" :  1,
            "access": "coap://127.0.0.1:5683/````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````mb/bus-1/1/2?coding=iabcd"
        },

```

输出：
```
        t0 AT %QW0 : INT;
        t1 AT %QD2 : DINT;

        {
            "location": 0,
            "type": "INT",
            "num" :  1,
            "access": "coap://127.0.0.1:5683/mb/bus-1/1/100"
        },
        {
            "location": 2,
            "type": "DINT",
            "num" :  1,
            "access": "coap://127.0.0.1:5683/mb/bus-1/1/101?fc=16&coding=iabcd"
        },

```

验证：

t0 = x0 + 1
t1 = x1 -1

## 2 浮点
输入：t

```
        x2 AT %ID6 : REAL;
        {
            "location": 6,
            "type": "REAL",
            "num" :  1,
            "access": "coap://127.0.0.1:5683/mb/bus-1/1/4?coding=abcd"
        },

```


输出：
```
        t2 AT %QD6 : REAL;
        {
            "location": 6,
            "type": "REAL",
            "num" :  1,
            "access": "coap://127.0.0.1:5683/mb/bus-1/1/103?fc=16&coding=abcd"
        },
```
验证：
  - x2 = 65535.56
  - t2 = x2 


## 3 BOOL
测试：
- MB的COIL操作，和ST的BOOL变量的映射， IO MAP的`bit`字段
- 对于同一个INPUT位置按照BIT和字节的映射到不同的ST变量

输入：

```
        INPUT10_0 AT %IX10.0: BOOL;
        INPUT10_1 AT %IX10.1: BOOL;
        INPUT10  AT %IB10: BYTE;

        {
            "location": 10,
            "type": "BOOL",
            "bit" : 0,
            "num" :  1,
            "access": "coap://127.0.0.1:5683/mb/bus-1/1/10?fc=1"
        },
        {
            "location": 10,
            "type": "BOOL",
            "bit" : 1,
            "num" :  1,
            "access": "coap://127.0.0.1:5683/mb/bus-1/1/11?fc=1"
        },

```

输出：
```
        OUTPUT10  AT %IQ10: BYTE;
        OUTPUT11  AT %IQ11: BYTE;
        {
            "location": 10,
            "type": "BYTE",
            "num" :  2,
            "access": "coap://127.0.0.1:5683/mb/bus-1/1/10?fc=5&items=2"
        },
```

验证：
- 通过ST变量OUTPUT10/OUTPUT11 对MB的COIL 10/11进行设置
- 验证ST的输入变量等于之前OUTPUT内容
- 验证INPUT10和INPUT10_0/INPUT10_1为相同内存上的不同解读

## 4 BYTE[], num>1

- ST字节数组对应到多个IO连续的地址
- 测试`num` = 3
```
        INPUTS AT %IB12 : ARRAY[0..2] OF BYTE;

        {
            "location": 11,
            "type": "SINT",
            "num" :  3,
            "access": "coap://127.0.0.1:5683/mb/bus-1/1/10?fc=1&items=3"
        }

输出：
        OUTPUTS AT %QB12 : ARRAY[0..2] OF BYTE;
        {
            "location": 12,
            "type": "BYTE",
            "num" :  3,
            "access": "coap://127.0.0.1:5683/mb/bus-1/1/12?fc=5&items=3"
        }
```

验证：
- 输出使用跑马灯模式
- 验证输入等于输出