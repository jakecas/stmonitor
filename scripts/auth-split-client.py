#!/usr/bin/env python

import sys

SERVER_HOST = '127.0.0.1'
SERVER_PORT = int(sys.argv[1])

MON_HOST = '127.0.0.1'
MON_PORT = int(sys.argv[2])

import time
import re, socket
from timeit import Timer

MSG_SUCC_RE = re.compile('''^SUCC +(.+)''')
MSG_FAIL_RE = re.compile('''^FAIL +(.+)''')
MSG_RES_RE = re.compile('''^RES +(.+)''')
MSG_TIMEOUT = re.compile('''^TIMEOUT''')


def send_wrapper(s, m, msg):
    s.sendall(msg)
    m.sendall(msg)


def recv_wrapper(s, m, size):
    msg = s.recv(size)
    m.sendall(msg)
    return msg.decode().strip()


def connect_and_auth():
    s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
    m = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
    #print('[C] Client started')
    while s.connect_ex((SERVER_HOST,SERVER_PORT)) != 0:
        time.sleep(0.1)
    while m.connect_ex((MON_HOST,MON_PORT)) != 0:
        time.sleep(0.1)

    req = 'AUTH Bob ro5'
    #print("[C] Sending: " + req)
    send_wrapper(s, m, str.encode(req + '\n'))
    rsp = recv_wrapper(s, m, 32)
    #print("[C] Received:" + rsp)

    msg = MSG_SUCC_RE.match(rsp)
    if (msg is not None):
        tok = msg.group(1)
        req = "GET whatever "+ str(tok)
        #print("[C] Sending: " + req)
        send_wrapper(s, m, str.encode(req + '\n'))

        rsp = recv_wrapper(s, m, 32)
        #print("[C] Received:" + rsp)

        req = "RVK " + str(tok)
        #print("[C] Sending: " + req)
        send_wrapper(s, m, str.encode(req + '\n'))


print("Starting client.")
#start = time.time()
t = Timer(lambda: connect_and_auth())
timevals = t.repeat(repeat=int(sys.argv[3]), number=1)
#end = time.time()
#print("Total time: ", end - start)

logfile = open(sys.argv[4], 'w')
for val in timevals:
    logfile.write(str(val) + ",")