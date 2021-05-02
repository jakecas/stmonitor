import re, socket, sys

SERVER_HOST = '127.0.0.1'
SERVER_PORT = 4021

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

def serve(srv):
    print('[S] Waiting for new connections')
    (s, address) = srv.accept()
    print('[S] New connection from',address)
    handle_connection(s)
    print('[S] Closing connection')
    s.close()


def handle_connection(s):
    while 1:
#        print('[S] Waiting for READ, WRITE or CLOSE request')
        req = s.recv(1024).decode().strip()
        m_read = MSG_READ_RE.match(req)
        m_write = MSG_WRITE_RE.match(req)
        m_close = MSG_CLOSE_RE.match(req)

        if m_read is not None:
            handle_read(s, m_read)
        elif m_write is not None:
            handle_write(s, m_write)
        elif m_close is not None:
            print("[S] Received CLOSE request.")
            return
        else:
            print("[S] Invalid command: ", req)
            return


def handle_read(s, msg):
#    print("[S] Received READ request.")
    filename = msg.group(1)
    file = open(filename, 'r')
    filecontents = file.read()
    c = 1

    while len(filecontents[(c-1)*512:c*512]) == 512:
        s.sendall(str.encode(MSG_BLOCKR + str(c) + " 512 " + filecontents[(c-1)*512:c*512] + '\n'))
        rsp = s.recv(32).decode().strip()
        if MSG_ACKR_RE.match(rsp) is None:
            print("[S] ERROR: Did not receive ACKR after sending block ", c, " to client!")
        c += 1

    s.sendall(str.encode(MSG_BLOCKR + str(c) + " " + str(len(filecontents[(c-1)*512:])) + " " + filecontents[(c-1)*512:] + '\n'))
    rsp = s.recv(6).decode().strip()
    if MSG_ACKRF_RE.match(rsp) is None:
        print("[S] ERROR: Did not receive ACKRF after sending file to client!")

    file.close()


def handle_write(s, msg):
#    print("[S] Received WRITE request.")
    filename = msg.group(1)
    file = open("/home/jakec/Workspace/Uni/Thesis/Code/stmonitor/scripts/ftp/server/"+filename, 'w')
    s.sendall(str.encode(MSG_ACKWI + "\n"))

    req = s.recv(552).decode().strip()
    block = MSG_BLOCKW_RE.match(req)

    while block.group(2) == "512":
        file.write(block.group(3))
        s.sendall(str.encode(MSG_ACKW + block.group(1) + '\n'))
        req = s.recv(552).decode().strip()
        block = MSG_BLOCKW_RE.match(req)

    file.write(block.group(3))
    s.sendall(str.encode(MSG_ACKWF + '\n'))
    file.close()



if __name__ == '__main__':
    # SERVER_PORT = int(argv[1])
    print('[S] TFTP server starting. Press Ctrl+C to quit')
    srv = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
    srv.setsockopt(socket.SOL_SOCKET, socket.SO_REUSEADDR, 1)  # Avoid TIME_WAIT
    srv.bind((SERVER_HOST, SERVER_PORT))
    print('[S] Listening on ', SERVER_HOST, SERVER_PORT)
    srv.listen(8)
    serve(srv)
    srv.close()
