#!/usr/bin/env python

CLIENT_HOST = '127.0.0.1'
CLIENT_PORT = 1335

MON_HOST = '127.0.0.1'
MON_PORT = 1445

import re, socket

if (__name__ == '__main__'):
    print('[C] Client started')
    s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
    s.connect((CLIENT_HOST,CLIENT_PORT))
    mon = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
    mon.connect((MON_HOST,MON_PORT))

    reply = 'AUTH Bob ro5'
    print(f'[C] Sending: {reply}')
    mon.sendall(str.encode(reply+'\n'))
    s.sendall(str.encode(reply+'\n'))
    tmp = s.recv(16)
    mon.sendall(tmp)
    rcv = tmp.decode().strip()
    print('[C] Received:', rcv)

    reply = 'AUTH Chris 227'
    print(f'[C] Sending: {reply}')
    mon.sendall(str.encode(reply+'\n'))
    s.sendall(str.encode(reply+'\n'))
    tmp = s.recv(16)
    mon.sendall(tmp)
    rcv = tmp.decode().strip()
    print('[C] Received:', rcv)
    s.close()
