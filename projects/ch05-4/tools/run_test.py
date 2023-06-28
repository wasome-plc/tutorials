#!/usr/bin/env python3

# -*- coding: utf-8 -*-

import argparse
import datetime
import os
import pprint
import random
import re
import shlex
import subprocess
import signal
import sys
import time
import shutil
from subprocess import check_output, CalledProcessError
import json
import coapthon

import modbus_tk
import modbus_tk.defines as cst
from modbus_tk import modbus_tcp

def signal_handler(signal, frame):
        print('Pressed Ctrl+C!')
        sys.exit(0)

def Register_signal_handler():
    signal.signal(signal.SIGINT, signal_handler)
#    signal.pause()



if __name__ == "__main__":
    parser = argparse.ArgumentParser(description = "ch05-4")
    parser.add_argument('-b', dest='build',
            default = False, action = 'store_true',
            help='build the repo')
    host='127.0.0.1'
    port = 6002
    print("\nIO Mapping")
    print("------------------------------------------------------------")
    for r in [0, 1, 2, 3]:
        print(f'IX{r}0 <---> device_cha05_4/1/8{r+1}')
    for r in [0, 1, 2]:
        print(f'QX{r}0 <---> device_cha05_4/1/9{r+1}')
    print("\nCases Status")
    print("------------------------------------------------------------")
    Register_signal_handler()

    

    # Write values to modubs
    master = modbus_tcp.TcpMaster(host=host, port=port)

    data_in =   [[{'r':81, 'v':1}, {'r':82, 'v':1}, {'r':83, 'v':0}, {'r':84, 'v':0}], \
                 [{'r':81, 'v':1}, {'r':82, 'v':0}, {'r':83, 'v':1}, {'r':84, 'v':0}], \
                 [{'r':81, 'v':1}, {'r':82, 'v':1}, {'r':83, 'v':1}, {'r':84, 'v':0}], \
                 [{'r':81, 'v':0}, {'r':82, 'v':0}, {'r':83, 'v':0}, {'r':84, 'v':1}], \
                 [{'r':81, 'v':0}, {'r':82, 'v':0}, {'r':83, 'v':1}, {'r':84, 'v':1}], \
                 [{'r':81, 'v':0}, {'r':82, 'v':1}, {'r':83, 'v':0}, {'r':84, 'v':1}] \
                 ]; # %IX00 .. %IX30
                 
                 # inter lock, shall keep last status 
    data_out = [ [{'r':91, 'v':1}, {'r':92, 'v':1}, {'r':93, 'v':0}], \
                 [{'r':91, 'v':1}, {'r':92, 'v':0}, {'r':93, 'v':1}], \
                 [{'r':91, 'v':1}, {'r':92, 'v':0}, {'r':93, 'v':1}], \
                 [{'r':91, 'v':0}, {'r':92, 'v':0}, {'r':93, 'v':0}], \
                 [{'r':91, 'v':0}, {'r':92, 'v':0}, {'r':93, 'v':0}], \
                 [{'r':91, 'v':0}, {'r':92, 'v':0}, {'r':93, 'v':0}] \
                 ]; # %QX00 .. %QX20
    success = True
    for i in range(len(data_in)):
        # write input modbus reg via coap
        for j in range(len(data_in[i])):
            res=master.execute(1,cst.WRITE_SINGLE_REGISTER, data_in[i][j]["r"], output_value=data_in[i][j]["v"])

        time.sleep(2);

        # read output modbus reg via coap 
        for j in range(len(data_out[i])):
            success = True
            response=master.execute(1,cst.READ_HOLDING_REGISTERS, data_out[i][j]["r"],1)
            if response == None :
                print(f'case{i}: FAIL:    reg{data_out[i][j]["r"]}, response code: {response}')
                success = False
                break

            return_data = response[0]
            if ((return_data==data_out[i][j]["v"])) == False:
                print(f'case{i}: FAIL:    {data_out[i][j]["r"]}:{data_out[i][j]["v"]}, confirm output fail, response payload: {response }, expect: {data_out[i][j]["v"]}')
                success = False
                break;
        if(success):
            print(f'case{i}: SUCCESS: response payload as expect')



