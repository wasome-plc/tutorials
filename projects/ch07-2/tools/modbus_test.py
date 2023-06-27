#!/usr/bin/env python3

# -*- coding: utf-8 -*-
"""
It is the entrance of the iagent test framework.

"""

import argparse
import datetime
import os
import random
import signal
import sys
import time
import shutil
from subprocess import check_output, CalledProcessError
import json
import modbus_tk
import modbus_tk.defines as cst
from modbus_tk import modbus_tcp
import logging

CASE_NAME = 'integration-01'

def signal_handler(signal, frame):
        print('Pressed Ctrl+C!')
        sys.exit(0)

def Register_signal_handler():
    signal.signal(signal.SIGINT, signal_handler)
#    signal.pause()

def register_value(s):
    return s[0]*256*256+s[1]

if __name__ == "__main__":


    parser = argparse.ArgumentParser(description = CASE_NAME)
    parser.add_argument('-r', dest='round',
            default = 1, action = 'store',
            help='test rounds')
    args = parser.parse_args()

    print("------------------------------------------------------------")
    print("parsing arguments ... ...")
    print(args)
    Register_signal_handler()

    logger = modbus_tk.utils.create_logger("console", level=logging.DEBUG)

    os.system('kill -9 `pidof modbus_test_server`');
    port=6003
    slave_id=3
    os.system(f'/ams/wa-agent/product/modbus_test_server -p {port} &')

    time.sleep(2)
    try:
        # Connect to the slave
        master = modbus_tcp.TcpMaster('127.0.0.1', port)
        master.set_timeout(5.0)

    except modbus_tk.modbus.ModbusError as exc:
        logger.error("%s- Code=%d", exc, exc.get_exception_code())
        sys.exit("connect fail")

    logger.info("tool: connected to modbus device")

    # Write values to modubs
    print ("start to set the modbus registers")
    random_number = random.randint(100,30000)
    res1=master.execute(slave_id, cst.WRITE_SINGLE_REGISTER, 1, output_value=random_number)
    print (f'write {random_number} to reg 1')

    value1=random.randint(0,100)
    value2=random.randint(0,100)
    res2=master.execute(slave_id, cst.WRITE_MULTIPLE_REGISTERS, 2, output_value=[value1,value2])
    print (f'write {value1*256*256+value2} to reg 2/3')

    value = 65535.56
    res3=master.execute(slave_id, cst.WRITE_MULTIPLE_REGISTERS, 4, output_value=[value], data_format='>f')
    print (f'write {value} to reg 4/5\n')

    val=random.randint(0,1)
    val1=random.randint(0,1)
    val2=random.randint(0,1)
    res1=master.execute(slave_id, cst.WRITE_MULTIPLE_REGISTERS, 12, output_value=[val,val1,val2])
    # expect the PLC APP will read from the register 1 and write it back to register 100
    print (f'write {[val,val1,val2]} to reg 12/13/14\n')
    print ("Start to read the modbus registers")
    cnt = 0
    while cnt < 3:
        cnt = cnt + 1
        time.sleep(2)
        response=master.execute(slave_id, cst.READ_HOLDING_REGISTERS, 100, 1)
        response2=master.execute(slave_id, cst.READ_HOLDING_REGISTERS, 101, 2)
        if response == None or response2 == None:
            print ("Failed to read from reg 100 and 101")
            continue;
        if len(response2) == None or len(response2) == 0 :
            print ("No data from reg 100, 101/102")
            continue;
        print (f'read {response[0]} from reg 100')
        if int(response[0]) == (random_number+1):
            print('..OK')
        else:
            continue
        print (f'read {register_value(response2)} from reg 101/102')
        if register_value(response2)== value1*256*256+value2-1:
            print('..OK')
            break;
        print('..Not OK')

    if cnt == 3:
        print("failed to get plc app pass IO test. exit..")
        sys.exit(1)

    print ("Passed INT and DINT test")
    print ("Starting REAL test..")

    cnt = 0
    while cnt < 3:
        cnt = cnt + 1
        time.sleep(1)
        response2 = master.execute(slave_id, cst.READ_HOLDING_REGISTERS, 103, 2, data_format='>f')
        if response2 == None:
            print ("Failed to read from reg 103/104")
            continue;
        if response2[0]== None :
            print ("No data read from reg 103/104")
            continue;
        print (f'read {response2[0]} from reg 103/104')
        if abs(float(response2[0]) - float(value)) < 0.1:
            print('..OK')
            break;
        print('..Not OK')

    if cnt == 3:
        print("failed to pass IO REAL TYPE test..")
        sys.exit(1)

    cnt = 0
    while cnt < 3:
        time.sleep(1.5)
        response2=master.execute(slave_id, cst.READ_HOLDING_REGISTERS, 112, 3)
        if len(response2)==0 or response2==None:
            print ("Failed to read from reg 112/113/114")
            continue;
        print (f'read {response2} from reg 112/113/114')
        if list[response2]==list[val,val1,val2]:
            print('..OK')
            break;
        print('..Not OK')
        cnt = cnt + 1
    if cnt == 3:
        print("failed to pass IO REAL TYPE test..")
        sys.exit(1)

    cnt = 0
    while cnt < 10:
        time.sleep(1)
        response2 = master.execute(slave_id, cst.READ_HOLDING_REGISTERS, 20, 1)
        if response2 == None or response2[0]!=1:
            print(f"failed to check error count：{response2[0]}")
            sys.exit(1)

        print(f'{cnt}: check error count OK..')
        cnt = cnt + 1
    sys.exit(0)

