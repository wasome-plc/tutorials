# CH07-5

## 测试原理

![](./doc/workflow.excalidraw.png)

## 测试条件

1. 目标设备上安装了iagent软件包
2. 目标设备上安装了Python3以及modbus_tk。执行命令安装：
```
pip install modbus_tk
```

## 测试工具test.py

在开始运行PLC应用或者源码调试之前，执行一下命令：
```
cd TOOLS
python3 test.py -p 1510
```
该命令将在本机启动两个MODDBUS TCP设备，从站ID均为1，IP地址和端口分别为：
- 127.0.0.1:1510
- 127.0.0.1:1511


## 部署和调试的网络设置

每次修改了IO配置后，启动调试或者配置，将会弹出以下窗口。如果前面test.py使用的`-p 1510`命令行参数，填写从站的IP地址和端口可以按照图片上内容填写。  

![](./doc/io_network.png)


