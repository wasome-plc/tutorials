#!/usr/bin/env python3

# -*- coding: utf-8 -*-
"""
It is the entrance of the iagent test framework.

"""

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

CASE_NAME = 'integration-01'

def signal_handler(signal, frame):
        print('Pressed Ctrl+C!')
        sys.exit(0)

def Register_signal_handler():
    signal.signal(signal.SIGINT, signal_handler)
#    signal.pause()



if __name__ == "__main__":


    parser = argparse.ArgumentParser(description = CASE_NAME)
    parser.add_argument('-b', dest='build',
            default = False, action = 'store_true',
            help='build the repo')
    parser.add_argument('-i', dest='debug_iagent',
            default = False, action = 'store_true',
            help='debug iagent')
    parser.add_argument('-d', dest='debug_runtime',
            default = False, action = 'store_true',
            help='enable debugging runtime')
    parser.add_argument('-a', dest='access',
            default = False, action = 'store_true',
            help='enable debugging runtime')
    parser.add_argument('-f', dest = 'binaries', action = 'store',
            help = 'The path of target folder ')
    args = parser.parse_args()

    print("------------------------------------------------------------")
    print("parsing arguments ... ...")
    print(args)
    Register_signal_handler()

    dirname, filename = os.path.split(os.path.abspath(sys.argv[0]))
    run_dir = dirname + "/run"
    repo_root_dir = os.path.abspath(os.path.join(dirname, "../../.."))


    sys.path.append(repo_root_dir + "/deps/CoAPthon3/coapthon")
    from coapthon.client.helperclient import HelperClient
    from coapthon import defines

    bus_name = "bus-1"

    # Write values to modubs
    print ("start to set the modbus registers")
    iagent_client = HelperClient(server=("127.0.0.1", 5683))
    random_number = random.randint(100,30000)
    path = "/mb/{}/1/1".format(bus_name)
    iagent_client.put(path, str(random_number))
    path = "/mb/{}/1/2?coding=iabcd&fc=16".format(bus_name)
    iagent_client.put(path, "6553512")
    path = "/mb/{}/1/4?coding=abcd&fc=16".format(bus_name)
    value = "65535.56"
    iagent_client.put(path, value)

    # expect the PLC APP will read from the register 1 and write it back to register 100
    print ("start to check the modbus registers")
    cnt = 0
    while cnt < 3:
        cnt = cnt + 1
        time.sleep(2)
        response = iagent_client.get("/mb/bus-1/1/100")
        response2 = iagent_client.get("/mb/bus-1/1/101?coding=iabcd")
        if response == None or response2 == None:
            continue;
        if response.payload == None or response2.payload == None :
            continue;
        if  response.code != defines.Codes.CONTENT.number or response2.code != defines.Codes.CONTENT.number:
            continue;
        if int(response.payload) == (random_number+1) and response2.payload == "6553511" :
            break;
        print("  {}:IO INT/DINT TYPE test. R100 returned: {}, expect: {}, R101 returned {}, expect: {}".format(cnt, str(response.payload), random_number+1, response2.payload , "6553511"))

    if cnt == 3:
        print("failed to get plc app pass IO test. exit..")
        sys.exit(1)

    print ("passed INT and DINT test..starting REAL test..")

    cnt = 0
    while cnt < 3:
        time.sleep(1)
        response2 = iagent_client.get("/mb/bus-1/1/103?coding=abcd")
        if response2 == None:
            continue;
        if response2.payload == None :
            continue;
        if  response2.code != defines.Codes.CONTENT.number:
            continue;
        if response2 == None or response2.payload == None:
            continue;
        if abs(float(response2.payload) - float(value)) < 0.1:
            break;
        print("  {}:IO REAL TYPE test. returned: {}, expect: {}".format(cnt, str(response2.payload), value))
        cnt = cnt + 1

    if cnt == 3:
        print("failed to pass IO REAL TYPE test..")
        sys.exit(1)


    cnt = 0
    while cnt < 10:
        time.sleep(1)
        response2 = iagent_client.get("/mb/bus-1/1/20")
        if response2.code != defines.Codes.CONTENT.number or response2.payload != '1':
            print("failed to check error count：" + str(response2.payload))
            sys.exit(1)

        print(f'{cnt}: check error count OK..')
        cnt = cnt + 1

    print("Pass!")

    sys.exit(0)

