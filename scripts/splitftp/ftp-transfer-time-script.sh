#!/usr/bin/env bash

echo "Measuring how transfer time varies over 10000 iterations."
echo "Control - Small file, read"
python3 server/tftp-server.py &
python3 client/tftp-client.py 4021 10000 tr small-test-file.txt logs/time/tr-small.txt
sleep 5
echo "Control - Small file, write"
python3 server/tftp-server.py &
python3 client/tftp-client.py 4021 10000 tw small-test-file.txt logs/time/tw-small.txt
sleep 5

echo "Control - Medium file, read"
python3 server/tftp-server.py &
python3 client/tftp-client.py 4021 10000 tr medium-test-file.txt logs/time/tr-med.txt
sleep 5
echo "Control - Medium file, write"
python3 server/tftp-server.py &
python3 client/tftp-client.py 4021 10000 tw medium-test-file.txt logs/time/tw-med.txt
sleep 5

echo "Control - Large file, read"
python3 server/tftp-server.py &
python3 client/tftp-client.py 4021 10000 tr large-test-file.txt logs/time/tr-large.txt
sleep 5
echo "Control - Large file, write"
python3 server/tftp-server.py &
python3 client/tftp-client.py 4021 10000 tw large-test-file.txt logs/time/tw-large.txt
sleep 5

echo "Partial Id - Small file, read"
python3 server/tftp-server.py &
java -Xss16M -cp ../../examples/target/scala-2.12/examples-assembly-0.0.3.jar examples.ftp.MonRunner 4021 4000 &
python3 client/tftp-client.py 4000 10000 tr small-test-file.txt logs/time/tr-small-mon.txt
sleep 5
echo "Partial Id - Small file, read"
python3 server/tftp-server.py &
java -Xss16M -cp ../../examples/target/scala-2.12/examples-assembly-0.0.3.jar examples.ftp.MonRunner 4021 4000 &
python3 client/tftp-client.py 4000 10000 tw small-test-file.txt logs/time/tw-small-mon.txt
sleep 5

echo "Partial Id - Medium file, read"
python3 server/tftp-server.py &
java -Xss32M -cp ../../examples/target/scala-2.12/examples-assembly-0.0.3.jar examples.ftp.MonRunner 4021 4000 &
python3 client/tftp-client.py 4000 10000 tr medium-test-file.txt logs/time/tr-med-mon.txt
sleep 5
echo "Partial Id - Medium file, write"
python3 server/tftp-server.py &
java -Xss32M -cp ../../examples/target/scala-2.12/examples-assembly-0.0.3.jar examples.ftp.MonRunner 4021 4000 &
python3 client/tftp-client.py 4000 10000 tw medium-test-file.txt logs/time/tw-med-mon.txt
sleep 5

echo "Partial Id - Large file, read"
python3 server/tftp-server.py &
java -Xss32M -cp ../../examples/target/scala-2.12/examples-assembly-0.0.3.jar examples.ftp.MonRunner 4021 4000 &
python3 client/tftp-client.py 4000 10000 tr large-test-file.txt logs/time/tr-large-mon.txt
sleep 5
echo "Partial Id - Large file, write"
python3 server/tftp-server.py &
java -Xss32M -cp ../../examples/target/scala-2.12/examples-assembly-0.0.3.jar examples.ftp.MonRunner 4021 4000 &
python3 client/tftp-client.py 4000 10000 tw large-test-file.txt logs/time/tw-large-mon.txt
sleep 5
