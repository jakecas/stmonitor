import re, socket, time, sys
from timeit import Timer

SERVER_HOST = '127.0.0.1'
SERVER_PORT = 4021
MON_HOST = '127.0.0.1'
MON_PORT = int(sys.argv[1])

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

def send_wrapper(s, m, msg):
    s.sendall(msg)
    m.sendall(msg)


def recv_wrapper(s, m, size):
    msg = s.recv(size)
    m.sendall(msg)
    return msg.decode().strip()


def handle_read(s, m, filename):
    send_wrapper(s, m, str.encode(MSG_READ + filename + '\n'))
    data = ""

    req = recv_wrapper(s, m, 552)
    block = MSG_BLOCKR_RE.match(req)

    while block.group(2) == "512":
        data += block.group(3)
        send_wrapper(s, m, str.encode(MSG_ACKR + block.group(1) + "\n"))
        req = recv_wrapper(s, m, 552)
        block = MSG_BLOCKR_RE.match(req)

    data += block.group(3)
    send_wrapper(s, m, str.encode(MSG_ACKRF + "\n"))
    file = open("/home/jakec/Thesis/scripts/splitftp/client/"+filename, 'w')
    file.write(data)
    file.close()


def handle_write(s, m, filename):
    send_wrapper(s, m, str.encode(MSG_WRITE + filename + '\n'))
    rsp = recv_wrapper(s, m, 6)
    if MSG_ACKWI_RE.match(rsp) is None:
        print("[C] ERROR: Did not receive ACKWI after sending WRITE request to server!")
    file = open(filename, 'r')
    filecontents = file.read()
    c = 1

    while len(filecontents[(c-1)*512:c*512]) == 512:
        send_wrapper(s, m, str.encode(MSG_BLOCKW + str(c) + " 512 " + filecontents[(c-1)*512:c*512] + '\n'))
        rsp = recv_wrapper(s, m, 32)
        if MSG_ACKW_RE.match(rsp) is None:
            print("[C] ERROR: Did not receive ACKW after sending block ", c, " to server!")
        c += 1

    send_wrapper(s, m, str.encode(MSG_BLOCKW + str(c) + " " + str(len(filecontents[(c-1)*512:])) + " " + filecontents[(c-1)*512:] + '\n'))
    rsp = recv_wrapper(s, m, 6)
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
m = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
while m.connect_ex((MON_HOST,MON_PORT)) != 0:
    time.sleep(0.1)

if read and write:
    for i in range(iterations):
        handle_read(s, m, file)
        handle_write(s, m, file)
elif read:
    for i in range(iterations):
        handle_read(s, m, file)
elif write:
    for i in range(iterations):
        handle_write(s, m, file)

#t = Timer(lambda: handle_write(s, m, file))
#print(min(t.repeat(repeat=1000, number=1)))


send_wrapper(s, m, str.encode(MSG_CLOSE))
s.close()
m.close()
