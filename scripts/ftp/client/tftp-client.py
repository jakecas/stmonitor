import re, socket, time, sys
from timeit import Timer

SERVER_HOST = '127.0.0.1'
SERVER_PORT = int(sys.argv[1])

MSG_BLOCKR_RE = re.compile('''^BLOCKR ([0-9]+) ([0-9]+) ([\S\s]+)''')
MSG_ACKWI_RE = re.compile('''^ACKWI''')
MSG_ACKW_RE = re.compile('''^ACKW +(.+)''')
MSG_ACKWF_RE = re.compile('''^ACKWF''')

MSG_READ = "READ "
MSG_WRITE = "WRITE "
MSG_ACKR = "ACKR "
MSG_ACKRF = "ACKRF"
MSG_BLOCKW = "BLOCKW "
MSG_CLOSE = "CLOSE"


def handle_read(s, filename):
    s.sendall(str.encode(MSG_READ + filename + '\n'))
    file = open("/home/jakec/Workspace/Uni/Thesis/Code/stmonitor/scripts/ftp/client/"+filename, 'w')

    req = s.recv(552).decode().strip()
    block = MSG_BLOCKR_RE.match(req)

    while block.group(2) == "512":
        file.write(block.group(3))
        s.sendall(str.encode(MSG_ACKR + block.group(1) + "\n"))
        req = s.recv(552).decode().strip()
        block = MSG_BLOCKR_RE.match(req)

    file.write(block.group(3))
    s.sendall(str.encode(MSG_ACKRF + "\n"))
    file.close()


def handle_write(s, filename):
    s.sendall(str.encode(MSG_WRITE + filename + '\n'))
    rsp = s.recv(6).decode().strip()
    if MSG_ACKWI_RE.match(rsp) is None:
        print("[C] ERROR: Did not receive ACKWI after sending WRITE request to server!")
    file = open(filename, 'r')
    filecontents = file.read()
    c = 1

    while len(filecontents[(c-1)*512:c*512]) == 512:
        s.sendall(str.encode(MSG_BLOCKW + str(c) + " 512 " + filecontents[(c-1)*512:c*512] + '\n'))
        rsp = s.recv(32).decode().strip()
        if MSG_ACKW_RE.match(rsp) is None:
            print("[C] ERROR: Did not receive ACKW after sending block ", c, " to server!")
        c += 1

    s.sendall(str.encode(MSG_BLOCKW + str(c) + " " + str(len(filecontents[(c-1)*512:])) + " " + filecontents[(c-1)*512:] + '\n'))
    rsp = s.recv(6).decode().strip()
    if MSG_ACKWF_RE.match(rsp) is None:
        print("[C] ERROR: Did not receive ACKWF after sending file to server!")

    file.close()


iterations = int(sys.argv[2])
read = 'r' in str(sys.argv[3])
write = 'w' in str(sys.argv[3])
file = str(sys.argv[4])

s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
while s.connect_ex((SERVER_HOST,SERVER_PORT)) != 0:
    time.sleep(0.1)

if read and write:
    for i in range(iterations):
        handle_read(s, file)
        handle_write(s, file)
elif read:
    for i in range(iterations):
        handle_read(s, file)
elif write:
    for i in range(iterations):
        handle_write(s, file)

#t = Timer(lambda: handle_write(s, file))
#print(min(t.repeat(repeat=1000, number=1)))


s.sendall(str.encode(MSG_CLOSE))
s.close()
