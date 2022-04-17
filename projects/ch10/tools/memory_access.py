import sys
from coapthon.client.helperclient import HelperClient
from coapthon import defines
import time
import json

plc_name = 'test'

if (len(sys.argv) > 1):
    plc_name = sys.argv[1]

print("#### start to check the IO MEM .. ####")
client = HelperClient(server=("127.0.0.1", 8908))

write_values = [100, 50, 6789.123]
read_expect_values = [
    101,        # t0 := x0 + 1;
    49,         # t1 := x1 - 1;
    6789.123    # t2 := x2;
]
write_address = ['%IW0', '%ID2', '%ID6']
read_address = ['%QW0', '%QD2', '%QD6']
read_write_begin = [0, 2, 6]
read_write_type = ['INT', 'DINT', 'REAL']

# 访问IO区域测试，分别向ST程序中x0、x1、x2变量对应的地址处写入一个值，然后从对应的输出区读出值，检查是否符合预期
for i in range(3):
    print(f'write [{write_values[i]}] to [{write_address[i]}]')

    path = f'iomem?plc={plc_name}&io=i&begin={read_write_begin[i]}&num=1&type={read_write_type[i]}'
    values = [write_values[i]]
    payload = str(values)

    response = client.put(path, payload)
    if response == None or response.code != defines.Codes.CHANGED.number:
        print(f'PUT fail. {path}, response: {response.payload}')
        break

    # 等待0.8s后再从输出区读取值
    time.sleep(0.8)

    path = f'iomem?plc={plc_name}&io=o&begin={read_write_begin[i]}&num=1&type={read_write_type[i]}'

    response = client.get(path)
    if response == None or response.code != defines.Codes.CONTENT.number:
        print(f'GET fail. {path}')
        break

    return_data = json.loads(str(response.payload))
    if len(return_data) != 1:
        print(f'{i}: {path}, return not array: {response.payload }')
        break

    print(f'read value from [{read_address[i]}]: {return_data[0]}')

    if isinstance(read_expect_values[i], float):
        # 受浮点精度影响，最终得到的值不一定完全一致，这里我们允许0.1范围内的偏差
        if abs(return_data[0] - read_expect_values[i]) > 0.1:
            print(
                f'{i}: {path}, returned float: {response.payload }, expect: {read_expect_values[i]}')
            break

    elif return_data[0] != read_expect_values[i]:
        print(
            f'{i}: {path}, returned: {response.payload }, expect: {read_expect_values[i]}')
        break


# 访问共享内存区域测试，分别读出ST中各变量对应地址的值，检查是否与ST源码中赋值的常量相等
types =["BYTE","WORD","DWORD","LWORD","SINT","INT","DINT","LINT","REAL","LREAL"]
shm_expect_data = [127, 12345, 888888, 99999999999, -128, -
                   32768, -2147483648, -214748364888888, 3.14, 987654321.123]
cnt = 0
print('')
print(f'#### start test M area data .. ####')

while (cnt < len(shm_expect_data)):
    path = f'iomem?plc={plc_name}&io=m&begin={100 + cnt * 10}&num=1&type={types[cnt]}'
    response = client.get(path)

    return_data = json.loads(str(response.payload))

    if isinstance(shm_expect_data[cnt], float):
        if abs(return_data[0] - shm_expect_data[cnt]) > 0.1:
            print(
                f'{cnt}: {path}, returned float: {response.payload }, expect: {shm_expect_data[cnt]}')
            break

    elif return_data[0] != shm_expect_data[cnt]:
        print(
            f'{cnt}: {path}, returned: {response.payload }, expect: {shm_expect_data[cnt]}')
        break

    print(f'  {cnt}: pass. Type: {types[cnt]}, Data: {return_data[0]}')
    cnt += 1

if cnt < 10:
    print("failed to pass M area test. exit..")
    sys.exit(1)

print("Pass!")
