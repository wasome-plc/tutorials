# ethercat设备控制示例

## 配置主站

从WebConsole中配置主站0，如下图所示：
![](./doc/imgs/eth_master.png)

## 添加从站
确认wa-plc-framework软件在`running`状态

![](./doc/imgs/wa-plc-framework.png)

连接从站到网络并加电，从主站下的从站列表中可以看到新发现设备：

![](./doc/imgs/new_slave.png)

如果从站的地址为0，先设置从站的别名地址，然后选择“立即添加”。添加后需要重新启动wa-plc-framework才能生效!设备进入OP状态：

![](./doc/imgs/eth_slaves.png)

本实例中，汇川is620n伺服的从站地址为20，数字IO模块的从站地址为16。

## 配置从站
进入IS620N从站配置，首先设置时钟：

![](./doc/imgs/is620_clock.png)

然后配置PDO数据：

![](./doc/imgs/is620_sm2.png)

0x1600（SM2）:
```	
24640 (0x6040)  控制字 x
24698 (0x607a)  目标位置 x 
24760 (0x60b8)  探针模式
24672 (0x6060)  伺服模式选择  x
24830 (0x60fe)  SubIndex: 1, 物理输出
24831 (0x60ff)  目标速度  x

```
0x1a00 （SM3）：
```
24639 (0x603f)
24641 (0x6041) x
24676 (0x6064)  actualpos  x
24695 (0x6077)
2482 (0x9b2)
24761 (0x60b9)
24762 (0x60ba)
24764 (0x60bc)
24829 (0x60fd)
```

修改配置后需要wa-plc-framework才能生效!

### 注意： 汇川IS620N的配置！！！

目前此设备从webconsole添加后导出的PDO没有包含必要的寄存器0x6060与0x60ff。需要进行如下操作之一：

- 执行以下命令，将复制Test-Devices/is620n目录的文件至/wa-plc/ethercat/config下。 
```
cd Test-Devices
./install_cfg.sh
```

- 在WebConsole中在设备上创建pdo 0x1600（SM2）与0x1a00（SM3），在读出来的基础上增加寄存器0x6060与0x60ff


然后从web-console中重启wa-plc-framework.


