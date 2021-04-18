#!/bin/bash

iterations=(1000 2000 3000 4000 5000 6000 7000 8000 9000 10000)

for iter in "${iterations[@]}"; do
    /usr/bin/time --format="%e,%P,%M,%K" --output="logs/$iter-small-r-server.txt" python3 server/tftp-server.py &
    /usr/bin/time --format="%e,%P,%M,%K" --output="logs/$iter-small-r-client.txt" python3 client/tftp-client.py 4021 ${iter} r small-test-file.txt
    sleep 5
done
for iter in "${iterations[@]}"; do
    /usr/bin/time --format="%e,%P,%M,%K" --output="logs/$iter-small-w-server.txt" python3 server/tftp-server.py &
    /usr/bin/time --format="%e,%P,%M,%K" --output="logs/$iter-small-w-client.txt" python3 client/tftp-client.py 4021 ${iter} w small-test-file.txt
    sleep 5
done
for iter in "${iterations[@]}"; do
    /usr/bin/time --format="%e,%P,%M,%K" --output="logs/$iter-small-rw-server.txt" python3 server/tftp-server.py &
    /usr/bin/time --format="%e,%P,%M,%K" --output="logs/$iter-small-rw-client.txt" python3 client/tftp-client.py 4021 ${iter} rw small-test-file.txt
    sleep 5
done
for iter in "${iterations[@]}"; do
    /usr/bin/time --format="%e,%P,%M,%K" --output="logs/$iter-medium-r-server.txt" python3 server/tftp-server.py &
    /usr/bin/time --format="%e,%P,%M,%K" --output="logs/$iter-medium-r-client.txt" python3 client/tftp-client.py 4021 ${iter} r medium-test-file.txt
    sleep 5
done
for iter in "${iterations[@]}"; do
    /usr/bin/time --format="%e,%P,%M,%K" --output="logs/$iter-medium-w-server.txt" python3 server/tftp-server.py &
    /usr/bin/time --format="%e,%P,%M,%K" --output="logs/$iter-medium-w-client.txt" python3 client/tftp-client.py 4021 ${iter} w medium-test-file.txt
    sleep 5
done
for iter in "${iterations[@]}"; do
    /usr/bin/time --format="%e,%P,%M,%K" --output="logs/$iter-medium-rw-server.txt" python3 server/tftp-server.py &
    /usr/bin/time --format="%e,%P,%M,%K" --output="logs/$iter-medium-rw-client.txt" python3 client/tftp-client.py 4021 ${iter} rw medium-test-file.txt
    sleep 5
done
for iter in "${iterations[@]}"; do
    /usr/bin/time --format="%e,%P,%M,%K" --output="logs/$iter-small-r-dyn-server.txt" python3 server/tftp-server.py &
    /usr/bin/time --format="%e,%P,%M,%K" --output="logs/$iter-small-r-dyn-mon.txt" java -Xss16M -cp ../../benchmarks/target/scala-2.12/benchmarks-assembly-0.0.3.jar benchmarks.ftp.MonRunner 4021 4000 &
    /usr/bin/time --format="%e,%P,%M,%K" --output="logs/$iter-small-r-dyn-client.txt" python3 client/tftp-client.py 4000 ${iter} r small-test-file.txt
    sleep 5
done
for iter in "${iterations[@]}"; do
    /usr/bin/time --format="%e,%P,%M,%K" --output="logs/$iter-small-w-dyn-server.txt" python3 server/tftp-server.py &
    /usr/bin/time --format="%e,%P,%M,%K" --output="logs/$iter-small-r-dyn-mon.txt" java -Xss16M -cp ../../benchmarks/target/scala-2.12/benchmarks-assembly-0.0.3.jar benchmarks.ftp.MonRunner 4021 4000 &
    /usr/bin/time --format="%e,%P,%M,%K" --output="logs/$iter-small-w-dyn-client.txt" python3 client/tftp-client.py 4000 ${iter} w small-test-file.txt
    sleep 5
done
for iter in "${iterations[@]}"; do
    /usr/bin/time --format="%e,%P,%M,%K" --output="logs/$iter-small-rw-dyn-server.txt" python3 server/tftp-server.py &
    /usr/bin/time --format="%e,%P,%M,%K" --output="logs/$iter-small-r-dyn-mon.txt" java -Xss16M -cp ../../benchmarks/target/scala-2.12/benchmarks-assembly-0.0.3.jar benchmarks.ftp.MonRunner 4021 4000 &
    /usr/bin/time --format="%e,%P,%M,%K" --output="logs/$iter-small-rw-dyn-client.txt" python3 client/tftp-client.py 4000 ${iter} rw small-test-file.txt
    sleep 5
done
for iter in "${iterations[@]}"; do
    /usr/bin/time --format="%e,%P,%M,%K" --output="logs/$iter-medium-r-dyn-server.txt" python3 server/tftp-server.py &
    /usr/bin/time --format="%e,%P,%M,%K" --output="logs/$iter-medium-r-dyn-mon.txt" java -Xss32M -cp ../../benchmarks/target/scala-2.12/benchmarks-assembly-0.0.3.jar benchmarks.ftp.MonRunner 4021 4000 &
    /usr/bin/time --format="%e,%P,%M,%K" --output="logs/$iter-medium-r-dyn-client.txt" python3 client/tftp-client.py 4000 ${iter} r medium-test-file.txt
    sleep 5
done
for iter in "${iterations[@]}"; do
    /usr/bin/time --format="%e,%P,%M,%K" --output="logs/$iter-medium-w-dyn-server.txt" python3 server/tftp-server.py &
    /usr/bin/time --format="%e,%P,%M,%K" --output="logs/$iter-medium-r-dyn-mon.txt" java -Xss32M -cp ../../benchmarks/target/scala-2.12/benchmarks-assembly-0.0.3.jar benchmarks.ftp.MonRunner 4021 4000 &
    /usr/bin/time --format="%e,%P,%M,%K" --output="logs/$iter-medium-w-dyn-client.txt" python3 client/tftp-client.py 4000 ${iter} w medium-test-file.txt
    sleep 5
done
for iter in "${iterations[@]}"; do
    /usr/bin/time --format="%e,%P,%M,%K" --output="logs/$iter-medium-rw-dyn-server.txt" python3 server/tftp-server.py &
    /usr/bin/time --format="%e,%P,%M,%K" --output="logs/$iter-medium-r-dyn-mon.txt" java -Xss32M -cp ../../benchmarks/target/scala-2.12/benchmarks-assembly-0.0.3.jar benchmarks.ftp.MonRunner 4021 4000 &
    /usr/bin/time --format="%e,%P,%M,%K" --output="logs/$iter-medium-rw-dyn-client.txt" python3 client/tftp-client.py 4000 ${iter} rw medium-test-file.txt
    sleep 5
done
