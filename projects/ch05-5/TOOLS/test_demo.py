
#!/usr/bin/env python3

# -*- coding: utf-8 -*-
import sys
import time
import random
import os
import json
import argparse
import modbus_tk
import modbus_tk.defines as cst
from modbus_tk import modbus_tcp
import logging

if __name__ == "__main__":
    parser = argparse.ArgumentParser(description = "Modbus test server validator")
    parser.add_argument('-p', dest = 'port', action = 'store',
        default = 1510,
        help = 'modbus device port number')
    parser.add_argument('-s', dest = 'step', action = 'store_true',
        default = False,
        help = 'Wait input for each round')    
    args = parser.parse_args()

    dirname, filename = os.path.split(os.path.abspath(sys.argv[0]))
    port = int(args.port)
    fc_read = cst.READ_COILS
    fc_write = cst.WRITE_MULTIPLE_COILS
    logger = modbus_tk.utils.create_logger("console", level=logging.DEBUG)

    os.system('kill -9 `pidof modbus_test_server`');
    slave_id=3
    os.system(f'/ams/wa-agent/product/modbus_test_server -p {port} &')
    # os.system(f'/ams/wa-agent/product/modbus_test_server -p {port+1} &')

    time.sleep(2)
    try:
        # Connect to the slave
        master = modbus_tcp.TcpMaster('127.0.0.1', port)
        master.set_timeout(5.0)

    except modbus_tk.modbus.ModbusError as exc:
        logger.error("%s- Code=%d", exc, exc.get_exception_code())
        sys.exit("connect fail")

    logger.info("tool: connected to modbus device")

    v1 = 1
    v2 = 0
    result=''
    i=0
    # 要在 Python 中生成 0 和 1 的随机数，可以使用 random 模块中的 randint() 函数。randint() 函数用于生成指定范围内的整数，包括指定的开始和结束值。
    # 具体来说，要生成一个 0 或 1 的随机数，可以使用以下代码：
    import random
    
    while i<2:
        try:
            random_number = random.randint(0, 1)
            logger.info(f'random_number: {random_number}')
            master.execute(slave_id,cst.WRITE_SINGLE_COIL, 12, output_value = random_number)

            result = master.execute(slave_id,cst.READ_COILS, 12, 1)
            logger.info(f'Enter the current register value:{result}')
            if result[0] != random_number:
                sys.exit(f'read: {result}, not match prevoius write: {v2}')
            time.sleep(1.5)
            result1 = master.execute(slave_id,cst.READ_COILS, 14, 1)
            logger.info(f'Output the current register value:{result1}')
            if result1[0] != random_number:
                sys.exit(f'read: {result1}, not match prevoius write: {random_number}')
        except modbus_tk.modbus.ModbusError as exc:
            logger.error("%s- Code=%d", exc, exc.get_exception_code())
        except SystemExit as exc:
            print (f'{exc}, exiting...')
            break
        except Exception as exc:
            logger.error("Except:%s", exc)
        # 
        # if args.step:
        #     input(f'continue?') 
