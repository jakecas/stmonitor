import re, socket, sys, time

SERVER_HOST = '127.0.0.1'
SERVER_PORT = 4021
MON_HOST = '127.0.0.1'
MON_PORT = int(sys.argv[1])

MSG_READ_RE = re.compile('''^READ +(.+)''')
MSG_WRITE_RE = re.compile('''^WRITE +(.+)''')
MSG_ACKR_RE = re.compile('''^ACKR +(.+)''')
MSG_ACKRF_RE = re.compile('''^ACKRF''')
MSG_BLOCKW_RE = re.compile('''^BLOCKW ([0-9]+) ([0-9]+) ([\S\s]+)''')
MSG_CLOSE_RE = re.compile('''^CLOSE''')

MSG_BLOCKR = "BLOCKR "
MSG_ACKWI = "ACKWI"
MSG_ACKW = "ACKW "
MSG_ACKWF = "ACKWF"

def send_wrapper(s, m, msg):
    s.sendall(msg)
    m.sendall(msg)


def recv_wrapper(s, m, size):
    msg = s.recv(size)
    m.sendall(msg)
    return msg.decode().strip()


def serve(srv, m):
    print('[S] Waiting for new connections')
    (s, address) = srv.accept()
    print('[S] New connection from',address)
    handle_connection(s, m)
    print('[S] Closing connection')
    s.close()


def handle_connection(s, m):
    while 1:
#        print('[S] Waiting for READ, WRITE or CLOSE request')
        req = recv_wrapper(s, m, 1024)
        m_read = MSG_READ_RE.match(req)
        m_write = MSG_WRITE_RE.match(req)
        m_close = MSG_CLOSE_RE.match(req)

        if m_read is not None:
            handle_read(s, m_read, m)
        elif m_write is not None:
            handle_write(s, m_write, m)
        elif m_close is not None:
            print("[S] Received CLOSE request.")
            return
        else:
            print("[S] Invalid command: ", req)
            return


def handle_read(s, msg, m):
#    print("[S] Received READ request.")
    filename = msg.group(1)
    file = open(filename, 'r')
    filecontents = file.read()
    c = 1

    while len(filecontents[(c-1)*512:c*512]) == 512:
        send_wrapper(s, m, str.encode(MSG_BLOCKR + str(c) + " 512 " + filecontents[(c-1)*512:c*512] + '\n'))
        rsp = recv_wrapper(s, m, 32)
        if MSG_ACKR_RE.match(rsp) is None:
            print("[S] ERROR: Did not receive ACKR after sending block ", c, " to client!")
        c += 1

    send_wrapper(s, m, str.encode(MSG_BLOCKR + str(c) + " " + str(len(filecontents[(c-1)*512:])) + " " + filecontents[(c-1)*512:] + '\n'))
    rsp = recv_wrapper(s, m, 6)
    if MSG_ACKRF_RE.match(rsp) is None:
        print("[S] ERROR: Did not receive ACKRF after sending file to client!")

    file.close()


def handle_write(s, msg, m):
#    print("[S] Received WRITE request.")
    filename = msg.group(1)
    data = ""
    send_wrapper(s, m, str.encode(MSG_ACKWI + "\n"))

    req = recv_wrapper(s, m, 552)
    block = MSG_BLOCKW_RE.match(req)

    while block.group(2) == "512":
        data += block.group(3)
        send_wrapper(s, m, str.encode(MSG_ACKW + block.group(1) + '\n'))
        req = recv_wrapper(s, m, 552)
        block = MSG_BLOCKW_RE.match(req)

    data += block.group(3)
    send_wrapper(s, m, str.encode(MSG_ACKWF + '\n'))
    file = open("/home/jakec/Thesis/scripts/splitftp/server/"+filename, 'w')
    file.write(data)
    file.close()



if __name__ == '__main__':
    # SERVER_PORT = int(argv[1])
    print('[S] TFTP server starting. Press Ctrl+C to quit')
    srv = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
    srv.setsockopt(socket.SOL_SOCKET, socket.SO_REUSEADDR, 1)  # Avoid TIME_WAIT
    srv.bind((SERVER_HOST, SERVER_PORT))
    m = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
    while m.connect_ex((MON_HOST,MON_PORT)) != 0:
        time.sleep(0.1)
    print('[S] Listening on ', SERVER_HOST, SERVER_PORT)
    srv.listen(8)
    serve(srv, m)
    srv.close()
