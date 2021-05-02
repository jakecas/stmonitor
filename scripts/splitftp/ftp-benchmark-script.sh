#!/bin/bash

iterations=(100 200 300 400 500 600 700 800 900 1000 1500 2000 2500 3000 3500 4000 4500 5000 5500 6000 6500 7000 7500 8000 8500 9000 9500 10000)

for iter in "${iterations[@]}"; do
    /usr/bin/time --format="%e,%P,%M,%K" --output="logs/$iter-small-r-dyn-server.txt" python3 server/tftp-server.py 4000 &
    /usr/bin/time --format="%e,%P,%M,%K" --output="logs/$iter-small-r-dyn-smon.txt" java -Xss16M -cp ../../examples/target/scala-2.12/examples-assembly-0.0.3.jar examples.splitftp.ServerMonRunner 4000 &
    /usr/bin/time --format="%e,%P,%M,%K" --output="logs/$iter-small-r-dyn-cmon.txt" java -Xss16M -cp ../../examples/target/scala-2.12/examples-assembly-0.0.3.jar examples.splitftp.ClientMonRunner 4001 &
    /usr/bin/time --format="%e,%P,%M,%K" --output="logs/$iter-small-r-dyn-client.txt" python3 client/tftp-client.py 4001 ${iter} r small-test-file.txt
    sleep 5
    /usr/bin/time --format="%e,%P,%M,%K" --append --output="logs/$iter-small-r-dyn-server.txt" python3 server/tftp-server.py 4000 &
    /usr/bin/time --format="%e,%P,%M,%K" --append --output="logs/$iter-small-r-dyn-smon.txt" java -Xss16M -cp ../../examples/target/scala-2.12/examples-assembly-0.0.3.jar examples.splitftp.ServerMonRunner 4000 &
    /usr/bin/time --format="%e,%P,%M,%K" --append --output="logs/$iter-small-r-dyn-cmon.txt" java -Xss16M -cp ../../examples/target/scala-2.12/examples-assembly-0.0.3.jar examples.splitftp.ClientMonRunner 4001 &
    /usr/bin/time --format="%e,%P,%M,%K" --append --output="logs/$iter-small-r-dyn-client.txt" python3 client/tftp-client.py 4001 ${iter} r small-test-file.txt
    sleep 5
    /usr/bin/time --format="%e,%P,%M,%K" --append --output="logs/$iter-small-r-dyn-server.txt" python3 server/tftp-server.py 4000 &
    /usr/bin/time --format="%e,%P,%M,%K" --append --output="logs/$iter-small-r-dyn-smon.txt" java -Xss16M -cp ../../examples/target/scala-2.12/examples-assembly-0.0.3.jar examples.splitftp.ServerMonRunner 4000 &
    /usr/bin/time --format="%e,%P,%M,%K" --append --output="logs/$iter-small-r-dyn-cmon.txt" java -Xss16M -cp ../../examples/target/scala-2.12/examples-assembly-0.0.3.jar examples.splitftp.ClientMonRunner 4001 &
    /usr/bin/time --format="%e,%P,%M,%K" --append --output="logs/$iter-small-r-dyn-client.txt" python3 client/tftp-client.py 4001 ${iter} r small-test-file.txt
    sleep 5
done
for iter in "${iterations[@]}"; do
    /usr/bin/time --format="%e,%P,%M,%K" --output="logs/$iter-small-w-dyn-server.txt" python3 server/tftp-server.py 4000 &
    /usr/bin/time --format="%e,%P,%M,%K" --output="logs/$iter-small-w-dyn-smon.txt" java -Xss16M -cp ../../examples/target/scala-2.12/examples-assembly-0.0.3.jar examples.splitftp.ServerMonRunner 4000 &
    /usr/bin/time --format="%e,%P,%M,%K" --output="logs/$iter-small-w-dyn-cmon.txt" java -Xss16M -cp ../../examples/target/scala-2.12/examples-assembly-0.0.3.jar examples.splitftp.ClientMonRunner 4001 &
    /usr/bin/time --format="%e,%P,%M,%K" --output="logs/$iter-small-w-dyn-client.txt" python3 client/tftp-client.py 4001 ${iter} w small-test-file.txt
    sleep 5
    /usr/bin/time --format="%e,%P,%M,%K" --append --output="logs/$iter-small-w-dyn-server.txt" python3 server/tftp-server.py 4000 &
    /usr/bin/time --format="%e,%P,%M,%K" --append --output="logs/$iter-small-w-dyn-smon.txt" java -Xss16M -cp ../../examples/target/scala-2.12/examples-assembly-0.0.3.jar examples.splitftp.ServerMonRunner 4000 &
    /usr/bin/time --format="%e,%P,%M,%K" --append --output="logs/$iter-small-w-dyn-cmon.txt" java -Xss16M -cp ../../examples/target/scala-2.12/examples-assembly-0.0.3.jar examples.splitftp.ClientMonRunner 4001 &
    /usr/bin/time --format="%e,%P,%M,%K" --append --output="logs/$iter-small-w-dyn-client.txt" python3 client/tftp-client.py 4001 ${iter} w small-test-file.txt
    sleep 5
    /usr/bin/time --format="%e,%P,%M,%K" --append --output="logs/$iter-small-w-dyn-server.txt" python3 server/tftp-server.py 4000 &
    /usr/bin/time --format="%e,%P,%M,%K" --append --output="logs/$iter-small-w-dyn-smon.txt" java -Xss16M -cp ../../examples/target/scala-2.12/examples-assembly-0.0.3.jar examples.splitftp.ServerMonRunner 4000 &
    /usr/bin/time --format="%e,%P,%M,%K" --append --output="logs/$iter-small-w-dyn-cmon.txt" java -Xss16M -cp ../../examples/target/scala-2.12/examples-assembly-0.0.3.jar examples.splitftp.ClientMonRunner 4001 &
    /usr/bin/time --format="%e,%P,%M,%K" --append --output="logs/$iter-small-w-dyn-client.txt" python3 client/tftp-client.py 4001 ${iter} w small-test-file.txt
    sleep 5
done
for iter in "${iterations[@]}"; do
    /usr/bin/time --format="%e,%P,%M,%K" --output="logs/$iter-small-rw-dyn-server.txt" python3 server/tftp-server.py 4000 &
    /usr/bin/time --format="%e,%P,%M,%K" --output="logs/$iter-small-rw-dyn-smon.txt" java -Xss16M -cp ../../examples/target/scala-2.12/examples-assembly-0.0.3.jar examples.splitftp.ServerMonRunner 4000 &
    /usr/bin/time --format="%e,%P,%M,%K" --output="logs/$iter-small-rw-dyn-cmon.txt" java -Xss16M -cp ../../examples/target/scala-2.12/examples-assembly-0.0.3.jar examples.splitftp.ClientMonRunner 4001 &
    /usr/bin/time --format="%e,%P,%M,%K" --output="logs/$iter-small-rw-dyn-client.txt" python3 client/tftp-client.py 4001 ${iter} rw small-test-file.txt
    sleep 5
    /usr/bin/time --format="%e,%P,%M,%K" --append --output="logs/$iter-small-rw-dyn-server.txt" python3 server/tftp-server.py 4000 &
    /usr/bin/time --format="%e,%P,%M,%K" --append --output="logs/$iter-small-rw-dyn-smon.txt" java -Xss16M -cp ../../examples/target/scala-2.12/examples-assembly-0.0.3.jar examples.splitftp.ServerMonRunner 4000 &
    /usr/bin/time --format="%e,%P,%M,%K" --append --output="logs/$iter-small-rw-dyn-cmon.txt" java -Xss16M -cp ../../examples/target/scala-2.12/examples-assembly-0.0.3.jar examples.splitftp.ClientMonRunner 4001 &
    /usr/bin/time --format="%e,%P,%M,%K" --append --output="logs/$iter-small-rw-dyn-client.txt" python3 client/tftp-client.py 4001 ${iter} rw small-test-file.txt
    sleep 5
    /usr/bin/time --format="%e,%P,%M,%K" --append --output="logs/$iter-small-rw-dyn-server.txt" python3 server/tftp-server.py 4000 &
    /usr/bin/time --format="%e,%P,%M,%K" --append --output="logs/$iter-small-rw-dyn-smon.txt" java -Xss16M -cp ../../examples/target/scala-2.12/examples-assembly-0.0.3.jar examples.splitftp.ServerMonRunner 4000 &
    /usr/bin/time --format="%e,%P,%M,%K" --append --output="logs/$iter-small-rw-dyn-cmon.txt" java -Xss16M -cp ../../examples/target/scala-2.12/examples-assembly-0.0.3.jar examples.splitftp.ClientMonRunner 4001 &
    /usr/bin/time --format="%e,%P,%M,%K" --append --output="logs/$iter-small-rw-dyn-client.txt" python3 client/tftp-client.py 4001 ${iter} rw small-test-file.txt
    sleep 5
done
for iter in "${iterations[@]}"; do
    /usr/bin/time --format="%e,%P,%M,%K" --output="logs/$iter-medium-r-dyn-server.txt" python3 server/tftp-server.py 4000 &
    /usr/bin/time --format="%e,%P,%M,%K" --output="logs/$iter-medium-r-dyn-smon.txt" java -Xss32M -cp ../../examples/target/scala-2.12/examples-assembly-0.0.3.jar examples.splitftp.ServerMonRunner 4000 &
    /usr/bin/time --format="%e,%P,%M,%K" --output="logs/$iter-medium-r-dyn-cmon.txt" java -Xss32M -cp ../../examples/target/scala-2.12/examples-assembly-0.0.3.jar examples.splitftp.ClientMonRunner 4001 &
    /usr/bin/time --format="%e,%P,%M,%K" --output="logs/$iter-medium-r-dyn-client.txt" python3 client/tftp-client.py 4001 ${iter} r medium-test-file.txt
    sleep 5
    /usr/bin/time --format="%e,%P,%M,%K" --append --output="logs/$iter-medium-r-dyn-server.txt" python3 server/tftp-server.py 4000 &
    /usr/bin/time --format="%e,%P,%M,%K" --append --output="logs/$iter-medium-r-dyn-smon.txt" java -Xss32M -cp ../../examples/target/scala-2.12/examples-assembly-0.0.3.jar examples.splitftp.ServerMonRunner 4000 &
    /usr/bin/time --format="%e,%P,%M,%K" --append --output="logs/$iter-medium-r-dyn-cmon.txt" java -Xss32M -cp ../../examples/target/scala-2.12/examples-assembly-0.0.3.jar examples.splitftp.ClientMonRunner 4001 &
    /usr/bin/time --format="%e,%P,%M,%K" --append --output="logs/$iter-medium-r-dyn-client.txt" python3 client/tftp-client.py 4001 ${iter} r medium-test-file.txt
    sleep 5
    /usr/bin/time --format="%e,%P,%M,%K" --append --output="logs/$iter-medium-r-dyn-server.txt" python3 server/tftp-server.py 4000 &
    /usr/bin/time --format="%e,%P,%M,%K" --append --output="logs/$iter-medium-r-dyn-smon.txt" java -Xss32M -cp ../../examples/target/scala-2.12/examples-assembly-0.0.3.jar examples.splitftp.ServerMonRunner 4000 &
    /usr/bin/time --format="%e,%P,%M,%K" --append --output="logs/$iter-medium-r-dyn-cmon.txt" java -Xss32M -cp ../../examples/target/scala-2.12/examples-assembly-0.0.3.jar examples.splitftp.ClientMonRunner 4001 &
    /usr/bin/time --format="%e,%P,%M,%K" --append --output="logs/$iter-medium-r-dyn-client.txt" python3 client/tftp-client.py 4001 ${iter} r medium-test-file.txt
    sleep 5
done
for iter in "${iterations[@]}"; do
    /usr/bin/time --format="%e,%P,%M,%K" --output="logs/$iter-medium-w-dyn-server.txt" python3 server/tftp-server.py 4000 &
    /usr/bin/time --format="%e,%P,%M,%K" --output="logs/$iter-medium-w-dyn-smon.txt" java -Xss32M -cp ../../examples/target/scala-2.12/examples-assembly-0.0.3.jar examples.splitftp.ServerMonRunner 4000 &
    /usr/bin/time --format="%e,%P,%M,%K" --output="logs/$iter-medium-w-dyn-cmon.txt" java -Xss32M -cp ../../examples/target/scala-2.12/examples-assembly-0.0.3.jar examples.splitftp.ClientMonRunner 4001 &
    /usr/bin/time --format="%e,%P,%M,%K" --output="logs/$iter-medium-w-dyn-client.txt" python3 client/tftp-client.py 4001 ${iter} w medium-test-file.txt
    sleep 5
    /usr/bin/time --format="%e,%P,%M,%K" --append --output="logs/$iter-medium-w-dyn-server.txt" python3 server/tftp-server.py 4000 &
    /usr/bin/time --format="%e,%P,%M,%K" --append --output="logs/$iter-medium-w-dyn-smon.txt" java -Xss32M -cp ../../examples/target/scala-2.12/examples-assembly-0.0.3.jar examples.splitftp.ServerMonRunner 4000 &
    /usr/bin/time --format="%e,%P,%M,%K" --append --output="logs/$iter-medium-w-dyn-cmon.txt" java -Xss32M -cp ../../examples/target/scala-2.12/examples-assembly-0.0.3.jar examples.splitftp.ClientMonRunner 4001 &
    /usr/bin/time --format="%e,%P,%M,%K" --append --output="logs/$iter-medium-w-dyn-client.txt" python3 client/tftp-client.py 4001 ${iter} w medium-test-file.txt
    sleep 5
    /usr/bin/time --format="%e,%P,%M,%K" --append --output="logs/$iter-medium-w-dyn-server.txt" python3 server/tftp-server.py 4000 &
    /usr/bin/time --format="%e,%P,%M,%K" --append --output="logs/$iter-medium-w-dyn-smon.txt" java -Xss32M -cp ../../examples/target/scala-2.12/examples-assembly-0.0.3.jar examples.splitftp.ServerMonRunner 4000 &
    /usr/bin/time --format="%e,%P,%M,%K" --append --output="logs/$iter-medium-w-dyn-cmon.txt" java -Xss32M -cp ../../examples/target/scala-2.12/examples-assembly-0.0.3.jar examples.splitftp.ClientMonRunner 4001 &
    /usr/bin/time --format="%e,%P,%M,%K" --append --output="logs/$iter-medium-w-dyn-client.txt" python3 client/tftp-client.py 4001 ${iter} w medium-test-file.txt
    sleep 5
done
for iter in "${iterations[@]}"; do
    /usr/bin/time --format="%e,%P,%M,%K" --output="logs/$iter-medium-rw-dyn-server.txt" python3 server/tftp-server.py 4000 &
    /usr/bin/time --format="%e,%P,%M,%K" --output="logs/$iter-medium-rw-dyn-smon.txt" java -Xss32M -cp ../../examples/target/scala-2.12/examples-assembly-0.0.3.jar examples.splitftp.ServerMonRunner 4000 &
    /usr/bin/time --format="%e,%P,%M,%K" --output="logs/$iter-medium-rw-dyn-cmon.txt" java -Xss32M -cp ../../examples/target/scala-2.12/examples-assembly-0.0.3.jar examples.splitftp.ClientMonRunner 4001 &
    /usr/bin/time --format="%e,%P,%M,%K" --output="logs/$iter-medium-rw-dyn-client.txt" python3 client/tftp-client.py 4001 ${iter} rw medium-test-file.txt
    sleep 5
    /usr/bin/time --format="%e,%P,%M,%K" --append --output="logs/$iter-medium-rw-dyn-server.txt" python3 server/tftp-server.py 4000 &
    /usr/bin/time --format="%e,%P,%M,%K" --append --output="logs/$iter-medium-rw-dyn-smon.txt" java -Xss32M -cp ../../examples/target/scala-2.12/examples-assembly-0.0.3.jar examples.splitftp.ServerMonRunner 4000 &
    /usr/bin/time --format="%e,%P,%M,%K" --append --output="logs/$iter-medium-rw-dyn-cmon.txt" java -Xss32M -cp ../../examples/target/scala-2.12/examples-assembly-0.0.3.jar examples.splitftp.ClientMonRunner 4001 &
    /usr/bin/time --format="%e,%P,%M,%K" --append --output="logs/$iter-medium-rw-dyn-client.txt" python3 client/tftp-client.py 4001 ${iter} rw medium-test-file.txt
    sleep 5
    /usr/bin/time --format="%e,%P,%M,%K" --append --output="logs/$iter-medium-rw-dyn-server.txt" python3 server/tftp-server.py 4000 &
    /usr/bin/time --format="%e,%P,%M,%K" --append --output="logs/$iter-medium-rw-dyn-smon.txt" java -Xss32M -cp ../../examples/target/scala-2.12/examples-assembly-0.0.3.jar examples.splitftp.ServerMonRunner 4000 &
    /usr/bin/time --format="%e,%P,%M,%K" --append --output="logs/$iter-medium-rw-dyn-cmon.txt" java -Xss32M -cp ../../examples/target/scala-2.12/examples-assembly-0.0.3.jar examples.splitftp.ClientMonRunner 4001 &
    /usr/bin/time --format="%e,%P,%M,%K" --append --output="logs/$iter-medium-rw-dyn-client.txt" python3 client/tftp-client.py 4001 ${iter} rw medium-test-file.txt
    sleep 5
done
for iter in "${iterations[@]}"; do
    /usr/bin/time --format="%e,%P,%M,%K" --output="logs/$iter-large-r-dyn-server.txt" python3 server/tftp-server.py 4000 &
    /usr/bin/time --format="%e,%P,%M,%K" --output="logs/$iter-large-r-dyn-smon.txt" java -Xss40M -cp ../../examples/target/scala-2.12/examples-assembly-0.0.3.jar examples.splitftp.ServerMonRunner 4000 &
    /usr/bin/time --format="%e,%P,%M,%K" --output="logs/$iter-large-r-dyn-cmon.txt" java -Xss40M -cp ../../examples/target/scala-2.12/examples-assembly-0.0.3.jar examples.splitftp.ClientMonRunner 4001 &
    /usr/bin/time --format="%e,%P,%M,%K" --output="logs/$iter-large-r-dyn-client.txt" python3 client/tftp-client.py 4001 ${iter} r large-test-file.txt
    sleep 5
    /usr/bin/time --format="%e,%P,%M,%K" --append --output="logs/$iter-large-r-dyn-server.txt" python3 server/tftp-server.py 4000 &
    /usr/bin/time --format="%e,%P,%M,%K" --append --output="logs/$iter-large-r-dyn-smon.txt" java -Xss40M -cp ../../examples/target/scala-2.12/examples-assembly-0.0.3.jar examples.splitftp.ServerMonRunner 4000 &
    /usr/bin/time --format="%e,%P,%M,%K" --append --output="logs/$iter-large-r-dyn-cmon.txt" java -Xss40M -cp ../../examples/target/scala-2.12/examples-assembly-0.0.3.jar examples.splitftp.ClientMonRunner 4001 &
    /usr/bin/time --format="%e,%P,%M,%K" --append --output="logs/$iter-large-r-dyn-client.txt" python3 client/tftp-client.py 4001 ${iter} r large-test-file.txt
    sleep 5
    /usr/bin/time --format="%e,%P,%M,%K" --append --output="logs/$iter-large-r-dyn-server.txt" python3 server/tftp-server.py 4000 &
    /usr/bin/time --format="%e,%P,%M,%K" --append --output="logs/$iter-large-r-dyn-smon.txt" java -Xss40M -cp ../../examples/target/scala-2.12/examples-assembly-0.0.3.jar examples.splitftp.ServerMonRunner 4000 &
    /usr/bin/time --format="%e,%P,%M,%K" --append --output="logs/$iter-large-r-dyn-cmon.txt" java -Xss40M -cp ../../examples/target/scala-2.12/examples-assembly-0.0.3.jar examples.splitftp.ClientMonRunner 4001 &
    /usr/bin/time --format="%e,%P,%M,%K" --append --output="logs/$iter-large-r-dyn-client.txt" python3 client/tftp-client.py 4001 ${iter} r large-test-file.txt
    sleep 5
done
for iter in "${iterations[@]}"; do
    /usr/bin/time --format="%e,%P,%M,%K" --output="logs/$iter-large-w-dyn-server.txt" python3 server/tftp-server.py 4000 &
    /usr/bin/time --format="%e,%P,%M,%K" --output="logs/$iter-large-w-dyn-smon.txt" java -Xss40M -cp ../../examples/target/scala-2.12/examples-assembly-0.0.3.jar examples.splitftp.ServerMonRunner 4000 &
    /usr/bin/time --format="%e,%P,%M,%K" --output="logs/$iter-large-w-dyn-cmon.txt" java -Xss40M -cp ../../examples/target/scala-2.12/examples-assembly-0.0.3.jar examples.splitftp.ClientMonRunner 4001 &
    /usr/bin/time --format="%e,%P,%M,%K" --output="logs/$iter-large-w-dyn-client.txt" python3 client/tftp-client.py 4001 ${iter} w large-test-file.txt
    sleep 5
    /usr/bin/time --format="%e,%P,%M,%K" --append --output="logs/$iter-large-w-dyn-server.txt" python3 server/tftp-server.py 4000 &
    /usr/bin/time --format="%e,%P,%M,%K" --append --output="logs/$iter-large-w-dyn-smon.txt" java -Xss40M -cp ../../examples/target/scala-2.12/examples-assembly-0.0.3.jar examples.splitftp.ServerMonRunner 4000 &
    /usr/bin/time --format="%e,%P,%M,%K" --append --output="logs/$iter-large-w-dyn-cmon.txt" java -Xss40M -cp ../../examples/target/scala-2.12/examples-assembly-0.0.3.jar examples.splitftp.ClientMonRunner 4001 &
    /usr/bin/time --format="%e,%P,%M,%K" --append --output="logs/$iter-large-w-dyn-client.txt" python3 client/tftp-client.py 4001 ${iter} w large-test-file.txt
    sleep 5
    /usr/bin/time --format="%e,%P,%M,%K" --append --output="logs/$iter-large-w-dyn-server.txt" python3 server/tftp-server.py 4000 &
    /usr/bin/time --format="%e,%P,%M,%K" --append --output="logs/$iter-large-w-dyn-smon.txt" java -Xss40M -cp ../../examples/target/scala-2.12/examples-assembly-0.0.3.jar examples.splitftp.ServerMonRunner 4000 &
    /usr/bin/time --format="%e,%P,%M,%K" --append --output="logs/$iter-large-w-dyn-cmon.txt" java -Xss40M -cp ../../examples/target/scala-2.12/examples-assembly-0.0.3.jar examples.splitftp.ClientMonRunner 4001 &
    /usr/bin/time --format="%e,%P,%M,%K" --append --output="logs/$iter-large-w-dyn-client.txt" python3 client/tftp-client.py 4001 ${iter} w large-test-file.txt
    sleep 5
done
for iter in "${iterations[@]}"; do
    /usr/bin/time --format="%e,%P,%M,%K" --append --output="logs/$iter-large-rw-dyn-server.txt" python3 server/tftp-server.py 4000 &
    /usr/bin/time --format="%e,%P,%M,%K" --append --output="logs/$iter-large-rw-dyn-smon.txt" java -Xss68M -cp ../../examples/target/scala-2.12/examples-assembly-0.0.3.jar examples.splitftp.ServerMonRunner 4000 &
    /usr/bin/time --format="%e,%P,%M,%K" --append --output="logs/$iter-large-rw-dyn-cmon.txt" java -Xss68M -cp ../../examples/target/scala-2.12/examples-assembly-0.0.3.jar examples.splitftp.ClientMonRunner 4001 &
    /usr/bin/time --format="%e,%P,%M,%K" --append --output="logs/$iter-large-rw-dyn-client.txt" python3 client/tftp-client.py 4001 ${iter} rw large-test-file.txt
    sleep 5
done
