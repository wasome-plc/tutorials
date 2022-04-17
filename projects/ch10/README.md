# chapter 10, “上位机”程序开发

本例程演示如何通过coap或http接口访问PLC中的内存区域，主要包含如下内容：
1. PROGRAM/main.st

    使用ST语言编写的PLC程序，读写IO和共享内存区域

2. tools/memory_access.py

    python脚本实现的“上位机”程序，通过coap接口访问PLC的IO和共享内存区域

3. tools/plc_mem_interface.postman_collection.json

    postman工程文件，通过http接口访问PLC的IO和共享内存区域

## 依赖

- python脚本依赖coapthon3

    ``` bash
    pip3 install coapthon3
    ```

- postman

## 运行步骤

1. 使用WasomeIDE打开本示例，点击“编译”按钮
2. 在左侧边栏的“目标设备”栏中，找到待测试的设备并点击右侧的“部署当前应用”按钮

    > 注：若没有找到待测试的设备，点击“目标设备”右侧的“手动添加目标设备”按钮，填写设备的IP地址完成添加

3. 点击目标设备，右侧将打开该设备的网关管理系统。点击右上角的“创建PLC”按钮新建一个名叫“test”的PLC，并选择`ch10 (0.0.1)`作为应用程序

4. 运行memory_access.py脚本

    ``` bash
    python3 tools/memory_access.py test
    ```

    将输入如下内容：
    ``` bash
    #### start to check the IO MEM .. ####
    write [100] to [%IW0]
    read value from [%QW0]: 101
    write [50] to [%ID2]
    read value from [%QD2]: 49
    write [6789.123] to [%ID6]
    read value from [%QD6]: 6789.123046875

    #### start test M area data .. ####
    0: pass. Type: BYTE, Data: 127
    1: pass. Type: WORD, Data: 12345
    2: pass. Type: DWORD, Data: 888888
    3: pass. Type: LWORD, Data: 99999999999
    4: pass. Type: SINT, Data: -128
    5: pass. Type: INT, Data: -32768
    6: pass. Type: DINT, Data: -2147483648
    7: pass. Type: LINT, Data: -214748364888888
    8: pass. Type: REAL, Data: 3.140000104904175
    9: pass. Type: LREAL, Data: 987654321.123
    Pass!
    ```

5. 使用postman打开tools/plc_mem_interface.postman_collection.json

    postman工程中预设了一些请求，可以直接点击“发送”进行测试。若第三步创建的PLC名称不为`test`，则在测试前需将请求中的"PLC"参数更改为实际的PLC名称
