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
    os.system(f'/ams/wa-agent/product/modbus_test_server -p {port} &')
    os.system(f'/ams/wa-agent/product/modbus_test_server -p {port+1} &')

    time.sleep(2)

    try:
        # Connect to the slave
        master = modbus_tcp.TcpMaster('127.0.0.1', port)
        master.set_timeout(5.0)
        master2 = modbus_tcp.TcpMaster('127.0.0.1', port+1)
        master2.set_timeout(5.0)

    except modbus_tk.modbus.ModbusError as exc:
        logger.error("%s- Code=%d", exc, exc.get_exception_code())
        sys.exit("connect fail")

    logger.info("tool: connected to modbus device")

    v1 = 1
    v2 = 0
    v3 = 15.4
    result=''
    while True:
        try:
            v4 = random.randint(0, 1)
            master.execute(1,cst.WRITE_SINGLE_REGISTER, 100, output_value = v1)
            master.execute(1,cst.WRITE_MULTIPLE_REGISTERS, 101, output_value = [v1, v1, v1])
            master.execute(1,cst.WRITE_MULTIPLE_REGISTERS, 104, output_value = [v3, v3],data_format=">ff")
            master.execute(1,cst.WRITE_MULTIPLE_COILS, 80, output_value = [v2,v4])

            result = master.execute(1,cst.READ_HOLDING_REGISTERS, 100, 1)
            logger.info('read:' + str(result))
            time.sleep(2)
            
            result = master2.execute(1,cst.READ_HOLDING_REGISTERS, 100, 1)
            logger.info(result)
            if (result[0] != v1):
                sys.exit(f'read: {result}, not match prevoius write: {v1}')
            result = master2.execute(1,cst.READ_HOLDING_REGISTERS, 101, 3)
            logger.info(result)
            if (result != (v1, v1, v1)):
                sys.exit(f'read: {result}, not match prevoius write: {v1}')

            result = master2.execute(1,cst.READ_HOLDING_REGISTERS, 104, 4,data_format=">ff")
            logger.info(result)
            if (abs(float(result[0]) - float(v3))>0.1) and (abs(float(result[1]) - float(v3))>0.1):
                sys.exit(f'read: {result}, not match prevoius write: {v1}')

            result = master2.execute(1,cst.READ_COILS, 80, 2)
            logger.info(result)
            if result != (v2,v4):
                sys.exit(f'read: {result}, not match prevoius write: {v2}')
            v1 = v1 + 1
            v2 = 1 - v2
            v3 = v3 + 2.3

        except modbus_tk.modbus.ModbusError as exc:
            logger.error("%s- Code=%d", exc, exc.get_exception_code())
        except SystemExit as exc:
            print (f'{exc}, exiting...')
            break
        except Exception as exc:
            logger.error("Except:%s", exc)
        # 
        if args.step:
            input(f'continue?')