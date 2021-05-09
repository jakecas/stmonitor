#!/usr/bin/env bash

echo "Measuring how transfer time varies over 20000 iterations."
echo "Seq Analyzer - Small file, read"
python3 server/tftp-server.py 4000 &
java -Xss48M -cp ../../examples/target/scala-2.12/examples-assembly-0.0.3.jar examples.splitftp.ServerMonRunner 4000 &
java -Xss48M -cp ../../examples/target/scala-2.12/examples-assembly-0.0.3.jar examples.splitftp.ClientMonRunner 4001 &
python3 client/tftp-client.py 4001 20000 tr small-test-file.txt logs/time/tr-small-split.txt
sleep 5
echo "Seq Analyzer - Small file, read"
python3 server/tftp-server.py 4000 &
java -Xss48M -cp ../../examples/target/scala-2.12/examples-assembly-0.0.3.jar examples.splitftp.ServerMonRunner 4000 &
java -Xss48M -cp ../../examples/target/scala-2.12/examples-assembly-0.0.3.jar examples.splitftp.ClientMonRunner 4001 &
python3 client/tftp-client.py 4001 20000 tw small-test-file.txt logs/time/tw-small-split.txt
sleep 5

echo "Seq Analyzer - Medium file, read"
python3 server/tftp-server.py 4000 &
java -Xss96M -cp ../../examples/target/scala-2.12/examples-assembly-0.0.3.jar examples.splitftp.ServerMonRunner 4000 &
java -Xss96M -cp ../../examples/target/scala-2.12/examples-assembly-0.0.3.jar examples.splitftp.ClientMonRunner 4001 &
python3 client/tftp-client.py 4001 20000 tr medium-test-file.txt logs/time/tr-med-split.txt
sleep 5
echo "Seq Analyzer - Medium file, write"
python3 server/tftp-server.py 4000 &
java -Xss96M -cp ../../examples/target/scala-2.12/examples-assembly-0.0.3.jar examples.splitftp.ServerMonRunner 4000 &
java -Xss96M -cp ../../examples/target/scala-2.12/examples-assembly-0.0.3.jar examples.splitftp.ClientMonRunner 4001 &
python3 client/tftp-client.py 4001 20000 tw medium-test-file.txt logs/time/tw-med-split.txt
sleep 5

echo "Seq Analyzer - Large file, read"
python3 server/tftp-server.py 4000 &
java -Xss164M -cp ../../examples/target/scala-2.12/examples-assembly-0.0.3.jar examples.splitftp.ServerMonRunner 4000 &
java -Xss164M -cp ../../examples/target/scala-2.12/examples-assembly-0.0.3.jar examples.splitftp.ClientMonRunner 4001 &
python3 client/tftp-client.py 4001 20000 tr large-test-file.txt logs/time/tr-large-split.txt
sleep 5
echo "Seq Analyzer - Large file, write"
python3 server/tftp-server.py 4000 &
java -Xss164M -cp ../../examples/target/scala-2.12/examples-assembly-0.0.3.jar examples.splitftp.ServerMonRunner 4000 &
java -Xss164M -cp ../../examples/target/scala-2.12/examples-assembly-0.0.3.jar examples.splitftp.ClientMonRunner 4001 &
python3 client/tftp-client.py 4001 20000 tw large-test-file.txt logs/time/tw-large-split.txt
sleep 5
