#!/usr/bin/env python

import sys

SERVER_HOST = '127.0.0.1'
SERVER_PORT = int(sys.argv[1])

import time
import re, socket
from timeit import Timer

MSG_SUCC_RE = re.compile('''^SUCC +(.+)''')
MSG_FAIL_RE = re.compile('''^FAIL +(.+)''')
MSG_RES_RE = re.compile('''^RES +(.+)''')
MSG_TIMEOUT = re.compile('''^TIMEOUT''')

start = time.time()

def connect_and_auth():
    print('[C] Client started')
    s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
    while s.connect_ex((SERVER_HOST,SERVER_PORT)) != 0:
        time.sleep(0.1)

    req = 'AUTH Bob ro5'
    print("[C] Sending: " + req)
    s.sendall(str.encode(req + '\n'))
    rsp = s.recv(32).decode().strip()
    print("[C] Received:" + rsp)

    m = MSG_SUCC_RE.match(rsp)
    if (m is not None):
        tok = m.group(1)
        req = "GET whatever "+ str(tok)
        print("[C] Sending: " + req)
        s.sendall(str.encode(req + "\n"))

        rsp = s.recv(32).decode().strip()
        print("[C] Received:" + rsp)

        req = "RVK " + str(tok)
        print("[C] Sending: " + req)
        s.sendall(str.encode(req + "\n"))

t = Timer(lambda: connect_and_auth())
timevals = t.repeat(repeat=int(sys.argv[2]), number=1)
#end = time.time()
#print("Total time: ", end - start)

logfile = open(sys.argv[3], 'w')
for val in timevals:
    logfile.write(str(val) + ",")