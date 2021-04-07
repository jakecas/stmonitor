import re, socket

SERVER_HOST = '127.0.0.1'
SERVER_PORT = 4021

MSG_BLOCKR_RE = re.compile('''^BLOCKR ([0-9]+) ([\S\s]+)''')
MSG_ACKW_RE = re.compile('''^ACKW +(.+)''')
MSG_ACKWF_RE = re.compile('''^ACKWF''')

MSG_READ = "READ "
MSG_WRITE = "WRITE "
MSG_ACKR = "ACKR "
MSG_ACKRF = "ACKRF"
MSG_BLOCKW = "BLOCKW "


def handle_read(s, filename):
    s.sendall(str.encode(MSG_READ + filename + '\n'))
    file = open(filename, 'w')

    req = s.recv(1024).decode().strip()
    block = MSG_BLOCKR_RE.match(req)

    while len(block.group(2)) == 512:
        file.write(block.group(2))
        s.sendall(str.encode(MSG_ACKR + block.group(1) + "\n"))
        req = s.recv(1024).decode().strip()
        block = MSG_BLOCKR_RE.match(req)

    file.write(block.group(2))
    s.sendall(str.encode(MSG_ACKRF + "\n"))
    file.close()


def handle_write(s, filename):
    s.sendall(str.encode(MSG_WRITE + filename + '\n'))
    rsp = s.recv(1024).decode().strip()
    if MSG_ACKW_RE.match(rsp) is None:
        print("[C] ERROR: Did not receive ACKW 0 after sending WRITE request to server!")
    file = open(filename, 'r')
    filecontents = file.read()
    c = 1

    while len(filecontents[(c-1)*512:c*512]) == 512:
        s.sendall(str.encode(MSG_BLOCKW + str(c) + " " + filecontents[(c-1)*512:c*512] + '\n'))
        rsp = s.recv(1024).decode().strip()
        if MSG_ACKW_RE.match(rsp) is None:
            print("[C] ERROR: Did not receive ACKW after sending block ", c, " to server!")
        c += 1

    s.sendall(str.encode(MSG_BLOCKW + str(c) + " " + filecontents[(c-1)*512:] + '\n'))
    rsp = s.recv(1024).decode().strip()
    if MSG_ACKWF_RE.match(rsp) is None:
        print("[C] ERROR: Did not receive ACKWF after sending file to server!")

    file.close()


s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
s.connect((SERVER_HOST,SERVER_PORT))
handle_read(s, "client-test-file.txt")
