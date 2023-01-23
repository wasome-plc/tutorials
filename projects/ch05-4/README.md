# 功能
  本PLC APP使用梯形图LD语言开发，实现PLC领域典型的互锁联锁装置
  IX00、IX30分别为启动、停止QX00的按钮，具有互锁限制
  IX10和IX20分别控制QX10和QX20|同时QX00是必要条件，对QX10和QX20具有联锁限制

# 逻辑
![](./Doc/ld.png)

# 运行
- 1 目标机启动plc-manager， 并且配置modbus总线 bus-1
- 2 启动modbus simulator来模拟互锁联锁装置
- 3 编译PLC APP
- 4 在WebIDE的“目标设备”中添加待调试运行PLC APP的目标机IP地址， 并设置该目标设备为缺省设备
- 5 进入调试 

# 测试
 - 1 按“运行”的步骤启动PLC APP
 - 2 pip3 install -r tool/reuirements.txt
 - 3 python tool/run_test.py
   如果目标机不是本机， 请替换脚本中的ip地址127.0.0.1为目标机的IP，该脚本会使用API设置输入值， 利用API获取输出值，比较输出值与上表中的期望值是否一致， 一致则case pass   

## IO Mapping
  IX00 <---> /mb/bus-1/1/81
  IX10 <---> /mb/bus-1/1/82
  IX20 <---> /mb/bus-1/1/83
  IX30 <---> /mb/bus-1/1/84
  QX00 <---> /mb/bus-1/1/91
  QX10 <---> /mb/bus-1/1/92
  QX20 <---> /mb/bus-1/1/93
   
## 输入输出映射表
  IX00|IX10|IX20|IX30|=>|QX00|QX10|QX20
  -:|:-:|:-:|:-:|:-:|:-:|:-:|:-
  1|1|0|0|=>|1|1|0
  1|0|1|0|=>|1|0|1
  1|1|1|0|=>|1|0|0
  0|0|1|1|=>|0|0|0
  0|1|0|1|=>|0|0|0
    










