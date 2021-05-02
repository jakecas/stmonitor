#!/bin/bash

iterations=(100 200 300 400 500 600 700 800 900 1000 1500 2000 2500 3000 3500 4000 4500 5000 5500 6000 6500 7000 7500 8000 8500 9000 9500 10000)

for iter in "${iterations[@]}"; do
    /usr/bin/time --format="%e,%P,%M,%K" --output="logs/$iter-small-r-server.txt" python3 server/tftp-server.py &
    /usr/bin/time --format="%e,%P,%M,%K" --output="logs/$iter-small-r-client.txt" python3 client/tftp-client.py 4021 ${iter} r small-test-file.txt
    sleep 5
    /usr/bin/time --format="%e,%P,%M,%K" --append --output="logs/$iter-small-r-server.txt" python3 server/tftp-server.py &
    /usr/bin/time --format="%e,%P,%M,%K" --append --output="logs/$iter-small-r-client.txt" python3 client/tftp-client.py 4021 ${iter} r small-test-file.txt
    sleep 5
    /usr/bin/time --format="%e,%P,%M,%K" --append --output="logs/$iter-small-r-server.txt" python3 server/tftp-server.py &
    /usr/bin/time --format="%e,%P,%M,%K" --append --output="logs/$iter-small-r-client.txt" python3 client/tftp-client.py 4021 ${iter} r small-test-file.txt
    sleep 5
done
for iter in "${iterations[@]}"; do
    /usr/bin/time --format="%e,%P,%M,%K" --output="logs/$iter-small-w-server.txt" python3 server/tftp-server.py &
    /usr/bin/time --format="%e,%P,%M,%K" --output="logs/$iter-small-w-client.txt" python3 client/tftp-client.py 4021 ${iter} w small-test-file.txt
    sleep 5
    /usr/bin/time --format="%e,%P,%M,%K" --append --output="logs/$iter-small-w-server.txt" python3 server/tftp-server.py &
    /usr/bin/time --format="%e,%P,%M,%K" --append --output="logs/$iter-small-w-client.txt" python3 client/tftp-client.py 4021 ${iter} w small-test-file.txt
    sleep 5
    /usr/bin/time --format="%e,%P,%M,%K" --append --output="logs/$iter-small-w-server.txt" python3 server/tftp-server.py &
    /usr/bin/time --format="%e,%P,%M,%K" --append --output="logs/$iter-small-w-client.txt" python3 client/tftp-client.py 4021 ${iter} w small-test-file.txt
    sleep 5
done
for iter in "${iterations[@]}"; do
    /usr/bin/time --format="%e,%P,%M,%K" --output="logs/$iter-small-rw-server.txt" python3 server/tftp-server.py &
    /usr/bin/time --format="%e,%P,%M,%K" --output="logs/$iter-small-rw-client.txt" python3 client/tftp-client.py 4021 ${iter} rw small-test-file.txt
    sleep 5
    /usr/bin/time --format="%e,%P,%M,%K" --append --output="logs/$iter-small-rw-server.txt" python3 server/tftp-server.py &
    /usr/bin/time --format="%e,%P,%M,%K" --append --output="logs/$iter-small-rw-client.txt" python3 client/tftp-client.py 4021 ${iter} rw small-test-file.txt
    sleep 5
    /usr/bin/time --format="%e,%P,%M,%K" --append --output="logs/$iter-small-rw-server.txt" python3 server/tftp-server.py &
    /usr/bin/time --format="%e,%P,%M,%K" --append --output="logs/$iter-small-rw-client.txt" python3 client/tftp-client.py 4021 ${iter} rw small-test-file.txt
    sleep 5
done
for iter in "${iterations[@]}"; do
    /usr/bin/time --format="%e,%P,%M,%K" --output="logs/$iter-medium-r-server.txt" python3 server/tftp-server.py &
    /usr/bin/time --format="%e,%P,%M,%K" --output="logs/$iter-medium-r-client.txt" python3 client/tftp-client.py 4021 ${iter} r medium-test-file.txt
    sleep 5
    /usr/bin/time --format="%e,%P,%M,%K" --append --output="logs/$iter-medium-r-server.txt" python3 server/tftp-server.py &
    /usr/bin/time --format="%e,%P,%M,%K" --append --output="logs/$iter-medium-r-client.txt" python3 client/tftp-client.py 4021 ${iter} r medium-test-file.txt
    sleep 5
    /usr/bin/time --format="%e,%P,%M,%K" --append --output="logs/$iter-medium-r-server.txt" python3 server/tftp-server.py &
    /usr/bin/time --format="%e,%P,%M,%K" --append --output="logs/$iter-medium-r-client.txt" python3 client/tftp-client.py 4021 ${iter} r medium-test-file.txt
    sleep 5
done
for iter in "${iterations[@]}"; do
    /usr/bin/time --format="%e,%P,%M,%K" --output="logs/$iter-medium-w-server.txt" python3 server/tftp-server.py &
    /usr/bin/time --format="%e,%P,%M,%K" --output="logs/$iter-medium-w-client.txt" python3 client/tftp-client.py 4021 ${iter} w medium-test-file.txt
    sleep 5
    /usr/bin/time --format="%e,%P,%M,%K" --append --output="logs/$iter-medium-w-server.txt" python3 server/tftp-server.py &
    /usr/bin/time --format="%e,%P,%M,%K" --append --output="logs/$iter-medium-w-client.txt" python3 client/tftp-client.py 4021 ${iter} w medium-test-file.txt
    sleep 5
    /usr/bin/time --format="%e,%P,%M,%K" --append --output="logs/$iter-medium-w-server.txt" python3 server/tftp-server.py &
    /usr/bin/time --format="%e,%P,%M,%K" --append --output="logs/$iter-medium-w-client.txt" python3 client/tftp-client.py 4021 ${iter} w medium-test-file.txt
    sleep 5
done
for iter in "${iterations[@]}"; do
    /usr/bin/time --format="%e,%P,%M,%K" --output="logs/$iter-medium-rw-server.txt" python3 server/tftp-server.py &
    /usr/bin/time --format="%e,%P,%M,%K" --output="logs/$iter-medium-rw-client.txt" python3 client/tftp-client.py 4021 ${iter} rw medium-test-file.txt
    sleep 5
    /usr/bin/time --format="%e,%P,%M,%K" --append --output="logs/$iter-medium-rw-server.txt" python3 server/tftp-server.py &
    /usr/bin/time --format="%e,%P,%M,%K" --append --output="logs/$iter-medium-rw-client.txt" python3 client/tftp-client.py 4021 ${iter} rw medium-test-file.txt
    sleep 5
    /usr/bin/time --format="%e,%P,%M,%K" --append --output="logs/$iter-medium-rw-server.txt" python3 server/tftp-server.py &
    /usr/bin/time --format="%e,%P,%M,%K" --append --output="logs/$iter-medium-rw-client.txt" python3 client/tftp-client.py 4021 ${iter} rw medium-test-file.txt
    sleep 5
done
for iter in "${iterations[@]}"; do
    /usr/bin/time --format="%e,%P,%M,%K" --output="logs/$iter-large-r-server.txt" python3 server/tftp-server.py &
    /usr/bin/time --format="%e,%P,%M,%K" --output="logs/$iter-large-r-client.txt" python3 client/tftp-client.py 4021 ${iter} r large-test-file.txt
    sleep 5
    /usr/bin/time --format="%e,%P,%M,%K" --append --output="logs/$iter-large-r-server.txt" python3 server/tftp-server.py &
    /usr/bin/time --format="%e,%P,%M,%K" --append --output="logs/$iter-large-r-client.txt" python3 client/tftp-client.py 4021 ${iter} r large-test-file.txt
    sleep 5
    /usr/bin/time --format="%e,%P,%M,%K" --append --output="logs/$iter-large-r-server.txt" python3 server/tftp-server.py &
    /usr/bin/time --format="%e,%P,%M,%K" --append --output="logs/$iter-large-r-client.txt" python3 client/tftp-client.py 4021 ${iter} r large-test-file.txt
    sleep 5
done
for iter in "${iterations[@]}"; do
    /usr/bin/time --format="%e,%P,%M,%K" --output="logs/$iter-large-w-server.txt" python3 server/tftp-server.py &
    /usr/bin/time --format="%e,%P,%M,%K" --output="logs/$iter-large-w-client.txt" python3 client/tftp-client.py 4021 ${iter} w large-test-file.txt
    sleep 5
    /usr/bin/time --format="%e,%P,%M,%K" --append --output="logs/$iter-large-w-server.txt" python3 server/tftp-server.py &
    /usr/bin/time --format="%e,%P,%M,%K" --append --output="logs/$iter-large-w-client.txt" python3 client/tftp-client.py 4021 ${iter} w large-test-file.txt
    sleep 5
    /usr/bin/time --format="%e,%P,%M,%K" --append --output="logs/$iter-large-w-server.txt" python3 server/tftp-server.py &
    /usr/bin/time --format="%e,%P,%M,%K" --append --output="logs/$iter-large-w-client.txt" python3 client/tftp-client.py 4021 ${iter} w large-test-file.txt
    sleep 5
done
for iter in "${iterations[@]}"; do
    /usr/bin/time --format="%e,%P,%M,%K" --output="logs/$iter-large-rw-server.txt" python3 server/tftp-server.py &
    /usr/bin/time --format="%e,%P,%M,%K" --output="logs/$iter-large-rw-client.txt" python3 client/tftp-client.py 4021 ${iter} rw large-test-file.txt
    sleep 5
    /usr/bin/time --format="%e,%P,%M,%K" --append --output="logs/$iter-large-rw-server.txt" python3 server/tftp-server.py &
    /usr/bin/time --format="%e,%P,%M,%K" --append --output="logs/$iter-large-rw-client.txt" python3 client/tftp-client.py 4021 ${iter} rw large-test-file.txt
    sleep 5
    /usr/bin/time --format="%e,%P,%M,%K" --append --output="logs/$iter-large-rw-server.txt" python3 server/tftp-server.py &
    /usr/bin/time --format="%e,%P,%M,%K" --append --output="logs/$iter-large-rw-client.txt" python3 client/tftp-client.py 4021 ${iter} rw large-test-file.txt
    sleep 5
done
for iter in "${iterations[@]}"; do
    /usr/bin/time --format="%e,%P,%M,%K" --output="logs/$iter-small-r-dyn-server.txt" python3 server/tftp-server.py &
    /usr/bin/time --format="%e,%P,%M,%K" --output="logs/$iter-small-r-dyn-mon.txt" java -Xss16M -cp ../../examples/target/scala-2.12/examples-assembly-0.0.3.jar examples.ftp.MonRunner 4021 4000 &
    /usr/bin/time --format="%e,%P,%M,%K" --output="logs/$iter-small-r-dyn-client.txt" python3 client/tftp-client.py 4000 ${iter} r small-test-file.txt
    sleep 5
    /usr/bin/time --format="%e,%P,%M,%K" --append --output="logs/$iter-small-r-dyn-server.txt" python3 server/tftp-server.py &
    /usr/bin/time --format="%e,%P,%M,%K" --append --output="logs/$iter-small-r-dyn-mon.txt" java -Xss16M -cp ../../examples/target/scala-2.12/examples-assembly-0.0.3.jar examples.ftp.MonRunner 4021 4000 &
    /usr/bin/time --format="%e,%P,%M,%K" --append --output="logs/$iter-small-r-dyn-client.txt" python3 client/tftp-client.py 4000 ${iter} r small-test-file.txt
    sleep 5
    /usr/bin/time --format="%e,%P,%M,%K" --append --output="logs/$iter-small-r-dyn-server.txt" python3 server/tftp-server.py &
    /usr/bin/time --format="%e,%P,%M,%K" --append --output="logs/$iter-small-r-dyn-mon.txt" java -Xss16M -cp ../../examples/target/scala-2.12/examples-assembly-0.0.3.jar examples.ftp.MonRunner 4021 4000 &
    /usr/bin/time --format="%e,%P,%M,%K" --append --output="logs/$iter-small-r-dyn-client.txt" python3 client/tftp-client.py 4000 ${iter} r small-test-file.txt
    sleep 5
done
for iter in "${iterations[@]}"; do
    /usr/bin/time --format="%e,%P,%M,%K" --output="logs/$iter-small-w-dyn-server.txt" python3 server/tftp-server.py &
    /usr/bin/time --format="%e,%P,%M,%K" --output="logs/$iter-small-w-dyn-mon.txt" java -Xss16M -cp ../../examples/target/scala-2.12/examples-assembly-0.0.3.jar examples.ftp.MonRunner 4021 4000 &
    /usr/bin/time --format="%e,%P,%M,%K" --output="logs/$iter-small-w-dyn-client.txt" python3 client/tftp-client.py 4000 ${iter} w small-test-file.txt
    sleep 5
    /usr/bin/time --format="%e,%P,%M,%K" --append --output="logs/$iter-small-w-dyn-server.txt" python3 server/tftp-server.py &
    /usr/bin/time --format="%e,%P,%M,%K" --append --output="logs/$iter-small-w-dyn-mon.txt" java -Xss16M -cp ../../examples/target/scala-2.12/examples-assembly-0.0.3.jar examples.ftp.MonRunner 4021 4000 &
    /usr/bin/time --format="%e,%P,%M,%K" --append --output="logs/$iter-small-w-dyn-client.txt" python3 client/tftp-client.py 4000 ${iter} w small-test-file.txt
    sleep 5
    /usr/bin/time --format="%e,%P,%M,%K" --append --output="logs/$iter-small-w-dyn-server.txt" python3 server/tftp-server.py &
    /usr/bin/time --format="%e,%P,%M,%K" --append --output="logs/$iter-small-w-dyn-mon.txt" java -Xss16M -cp ../../examples/target/scala-2.12/examples-assembly-0.0.3.jar examples.ftp.MonRunner 4021 4000 &
    /usr/bin/time --format="%e,%P,%M,%K" --append --output="logs/$iter-small-w-dyn-client.txt" python3 client/tftp-client.py 4000 ${iter} w small-test-file.txt
    sleep 5
done
for iter in "${iterations[@]}"; do
    /usr/bin/time --format="%e,%P,%M,%K" --output="logs/$iter-small-rw-dyn-server.txt" python3 server/tftp-server.py &
    /usr/bin/time --format="%e,%P,%M,%K" --output="logs/$iter-small-rw-dyn-mon.txt" java -Xss16M -cp ../../examples/target/scala-2.12/examples-assembly-0.0.3.jar examples.ftp.MonRunner 4021 4000 &
    /usr/bin/time --format="%e,%P,%M,%K" --output="logs/$iter-small-rw-dyn-client.txt" python3 client/tftp-client.py 4000 ${iter} rw small-test-file.txt
    sleep 5
    /usr/bin/time --format="%e,%P,%M,%K" --append --output="logs/$iter-small-rw-dyn-server.txt" python3 server/tftp-server.py &
    /usr/bin/time --format="%e,%P,%M,%K" --append --output="logs/$iter-small-rw-dyn-mon.txt" java -Xss16M -cp ../../examples/target/scala-2.12/examples-assembly-0.0.3.jar examples.ftp.MonRunner 4021 4000 &
    /usr/bin/time --format="%e,%P,%M,%K" --append --output="logs/$iter-small-rw-dyn-client.txt" python3 client/tftp-client.py 4000 ${iter} rw small-test-file.txt
    sleep 5
    /usr/bin/time --format="%e,%P,%M,%K" --append --output="logs/$iter-small-rw-dyn-server.txt" python3 server/tftp-server.py &
    /usr/bin/time --format="%e,%P,%M,%K" --append --output="logs/$iter-small-rw-dyn-mon.txt" java -Xss16M -cp ../../examples/target/scala-2.12/examples-assembly-0.0.3.jar examples.ftp.MonRunner 4021 4000 &
    /usr/bin/time --format="%e,%P,%M,%K" --append --output="logs/$iter-small-rw-dyn-client.txt" python3 client/tftp-client.py 4000 ${iter} rw small-test-file.txt
    sleep 5
done
for iter in "${iterations[@]}"; do
    /usr/bin/time --format="%e,%P,%M,%K" --output="logs/$iter-medium-r-dyn-server.txt" python3 server/tftp-server.py &
    /usr/bin/time --format="%e,%P,%M,%K" --output="logs/$iter-medium-r-dyn-mon.txt" java -Xss32M -cp ../../examples/target/scala-2.12/examples-assembly-0.0.3.jar examples.ftp.MonRunner 4021 4000 &
    /usr/bin/time --format="%e,%P,%M,%K" --output="logs/$iter-medium-r-dyn-client.txt" python3 client/tftp-client.py 4000 ${iter} r medium-test-file.txt
    sleep 5
    /usr/bin/time --format="%e,%P,%M,%K" --append --output="logs/$iter-medium-r-dyn-server.txt" python3 server/tftp-server.py &
    /usr/bin/time --format="%e,%P,%M,%K" --append --output="logs/$iter-medium-r-dyn-mon.txt" java -Xss32M -cp ../../examples/target/scala-2.12/examples-assembly-0.0.3.jar examples.ftp.MonRunner 4021 4000 &
    /usr/bin/time --format="%e,%P,%M,%K" --append --output="logs/$iter-medium-r-dyn-client.txt" python3 client/tftp-client.py 4000 ${iter} r medium-test-file.txt
    sleep 5
    /usr/bin/time --format="%e,%P,%M,%K" --append --output="logs/$iter-medium-r-dyn-server.txt" python3 server/tftp-server.py &
    /usr/bin/time --format="%e,%P,%M,%K" --append --output="logs/$iter-medium-r-dyn-mon.txt" java -Xss32M -cp ../../examples/target/scala-2.12/examples-assembly-0.0.3.jar examples.ftp.MonRunner 4021 4000 &
    /usr/bin/time --format="%e,%P,%M,%K" --append --output="logs/$iter-medium-r-dyn-client.txt" python3 client/tftp-client.py 4000 ${iter} r medium-test-file.txt
    sleep 5
done
for iter in "${iterations[@]}"; do
    /usr/bin/time --format="%e,%P,%M,%K" --output="logs/$iter-medium-w-dyn-server.txt" python3 server/tftp-server.py &
    /usr/bin/time --format="%e,%P,%M,%K" --output="logs/$iter-medium-w-dyn-mon.txt" java -Xss32M -cp ../../examples/target/scala-2.12/examples-assembly-0.0.3.jar examples.ftp.MonRunner 4021 4000 &
    /usr/bin/time --format="%e,%P,%M,%K" --output="logs/$iter-medium-w-dyn-client.txt" python3 client/tftp-client.py 4000 ${iter} w medium-test-file.txt
    sleep 5
    /usr/bin/time --format="%e,%P,%M,%K" --append --output="logs/$iter-medium-w-dyn-server.txt" python3 server/tftp-server.py &
    /usr/bin/time --format="%e,%P,%M,%K" --append --output="logs/$iter-medium-w-dyn-mon.txt" java -Xss32M -cp ../../examples/target/scala-2.12/examples-assembly-0.0.3.jar examples.ftp.MonRunner 4021 4000 &
    /usr/bin/time --format="%e,%P,%M,%K" --append --output="logs/$iter-medium-w-dyn-client.txt" python3 client/tftp-client.py 4000 ${iter} w medium-test-file.txt
    sleep 5
    /usr/bin/time --format="%e,%P,%M,%K" --append --output="logs/$iter-medium-w-dyn-server.txt" python3 server/tftp-server.py &
    /usr/bin/time --format="%e,%P,%M,%K" --append --output="logs/$iter-medium-w-dyn-mon.txt" java -Xss32M -cp ../../examples/target/scala-2.12/examples-assembly-0.0.3.jar examples.ftp.MonRunner 4021 4000 &
    /usr/bin/time --format="%e,%P,%M,%K" --append --output="logs/$iter-medium-w-dyn-client.txt" python3 client/tftp-client.py 4000 ${iter} w medium-test-file.txt
    sleep 5
done
for iter in "${iterations[@]}"; do
    /usr/bin/time --format="%e,%P,%M,%K" --output="logs/$iter-medium-rw-dyn-server.txt" python3 server/tftp-server.py &
    /usr/bin/time --format="%e,%P,%M,%K" --output="logs/$iter-medium-rw-dyn-mon.txt" java -Xss32M -cp ../../examples/target/scala-2.12/examples-assembly-0.0.3.jar examples.ftp.MonRunner 4021 4000 &
    /usr/bin/time --format="%e,%P,%M,%K" --output="logs/$iter-medium-rw-dyn-client.txt" python3 client/tftp-client.py 4000 ${iter} rw medium-test-file.txt
    sleep 5
    /usr/bin/time --format="%e,%P,%M,%K" --append --output="logs/$iter-medium-rw-dyn-server.txt" python3 server/tftp-server.py &
    /usr/bin/time --format="%e,%P,%M,%K" --append --output="logs/$iter-medium-rw-dyn-mon.txt" java -Xss32M -cp ../../examples/target/scala-2.12/examples-assembly-0.0.3.jar examples.ftp.MonRunner 4021 4000 &
    /usr/bin/time --format="%e,%P,%M,%K" --append --output="logs/$iter-medium-rw-dyn-client.txt" python3 client/tftp-client.py 4000 ${iter} rw medium-test-file.txt
    sleep 5
    /usr/bin/time --format="%e,%P,%M,%K" --append --output="logs/$iter-medium-rw-dyn-server.txt" python3 server/tftp-server.py &
    /usr/bin/time --format="%e,%P,%M,%K" --append --output="logs/$iter-medium-rw-dyn-mon.txt" java -Xss32M -cp ../../examples/target/scala-2.12/examples-assembly-0.0.3.jar examples.ftp.MonRunner 4021 4000 &
    /usr/bin/time --format="%e,%P,%M,%K" --append --output="logs/$iter-medium-rw-dyn-client.txt" python3 client/tftp-client.py 4000 ${iter} rw medium-test-file.txt
    sleep 5
done
for iter in "${iterations[@]}"; do
    /usr/bin/time --format="%e,%P,%M,%K" --output="logs/$iter-large-r-dyn-server.txt" python3 server/tftp-server.py &
    /usr/bin/time --format="%e,%P,%M,%K" --output="logs/$iter-large-r-dyn-mon.txt" java -Xss88M -cp ../../examples/target/scala-2.12/examples-assembly-0.0.3.jar examples.ftp.MonRunner 4021 4000 &
    /usr/bin/time --format="%e,%P,%M,%K" --output="logs/$iter-large-r-dyn-client.txt" python3 client/tftp-client.py 4000 ${iter} r large-test-file.txt
    sleep 5
    /usr/bin/time --format="%e,%P,%M,%K" --append --output="logs/$iter-large-r-dyn-server.txt" python3 server/tftp-server.py &
    /usr/bin/time --format="%e,%P,%M,%K" --append --output="logs/$iter-large-r-dyn-mon.txt" java -Xss88M -cp ../../examples/target/scala-2.12/examples-assembly-0.0.3.jar examples.ftp.MonRunner 4021 4000 &
    /usr/bin/time --format="%e,%P,%M,%K" --append --output="logs/$iter-large-r-dyn-client.txt" python3 client/tftp-client.py 4000 ${iter} r large-test-file.txt
    sleep 5
    /usr/bin/time --format="%e,%P,%M,%K" --append --output="logs/$iter-large-r-dyn-server.txt" python3 server/tftp-server.py &
    /usr/bin/time --format="%e,%P,%M,%K" --append --output="logs/$iter-large-r-dyn-mon.txt" java -Xss88M -cp ../../examples/target/scala-2.12/examples-assembly-0.0.3.jar examples.ftp.MonRunner 4021 4000 &
    /usr/bin/time --format="%e,%P,%M,%K" --append --output="logs/$iter-large-r-dyn-client.txt" python3 client/tftp-client.py 4000 ${iter} r large-test-file.txt
    sleep 5
done
for iter in "${iterations[@]}"; do
    /usr/bin/time --format="%e,%P,%M,%K" --output="logs/$iter-large-w-dyn-server.txt" python3 server/tftp-server.py &
    /usr/bin/time --format="%e,%P,%M,%K" --output="logs/$iter-large-w-dyn-mon.txt" java -Xss88M -cp ../../examples/target/scala-2.12/examples-assembly-0.0.3.jar examples.ftp.MonRunner 4021 4000 &
    /usr/bin/time --format="%e,%P,%M,%K" --output="logs/$iter-large-w-dyn-client.txt" python3 client/tftp-client.py 4000 ${iter} w large-test-file.txt
    sleep 5
    /usr/bin/time --format="%e,%P,%M,%K" --append --output="logs/$iter-large-w-dyn-server.txt" python3 server/tftp-server.py &
    /usr/bin/time --format="%e,%P,%M,%K" --append --output="logs/$iter-large-w-dyn-mon.txt" java -Xss88M -cp ../../examples/target/scala-2.12/examples-assembly-0.0.3.jar examples.ftp.MonRunner 4021 4000 &
    /usr/bin/time --format="%e,%P,%M,%K" --append --output="logs/$iter-large-w-dyn-client.txt" python3 client/tftp-client.py 4000 ${iter} w large-test-file.txt
    sleep 5
    /usr/bin/time --format="%e,%P,%M,%K" --append --output="logs/$iter-large-w-dyn-server.txt" python3 server/tftp-server.py &
    /usr/bin/time --format="%e,%P,%M,%K" --append --output="logs/$iter-large-w-dyn-mon.txt" java -Xss88M -cp ../../examples/target/scala-2.12/examples-assembly-0.0.3.jar examples.ftp.MonRunner 4021 4000 &
    /usr/bin/time --format="%e,%P,%M,%K" --append --output="logs/$iter-large-w-dyn-client.txt" python3 client/tftp-client.py 4000 ${iter} w large-test-file.txt
    sleep 5
done
for iter in "${iterations[@]}"; do
    /usr/bin/time --format="%e,%P,%M,%K" --output="logs/$iter-large-rw-dyn-server.txt" python3 server/tftp-server.py &
    /usr/bin/time --format="%e,%P,%M,%K" --output="logs/$iter-large-rw-dyn-mon.txt" java -Xss88M -cp ../../examples/target/scala-2.12/examples-assembly-0.0.3.jar examples.ftp.MonRunner 4021 4000 &
    /usr/bin/time --format="%e,%P,%M,%K" --output="logs/$iter-large-rw-dyn-client.txt" python3 client/tftp-client.py 4000 ${iter} rw large-test-file.txt
    sleep 5
    /usr/bin/time --format="%e,%P,%M,%K" --append --output="logs/$iter-large-rw-dyn-server.txt" python3 server/tftp-server.py &
    /usr/bin/time --format="%e,%P,%M,%K" --append --output="logs/$iter-large-rw-dyn-mon.txt" java -Xss88M -cp ../../examples/target/scala-2.12/examples-assembly-0.0.3.jar examples.ftp.MonRunner 4021 4000 &
    /usr/bin/time --format="%e,%P,%M,%K" --append --output="logs/$iter-large-rw-dyn-client.txt" python3 client/tftp-client.py 4000 ${iter} rw large-test-file.txt
    sleep 5
    /usr/bin/time --format="%e,%P,%M,%K" --append --output="logs/$iter-large-rw-dyn-server.txt" python3 server/tftp-server.py &
    /usr/bin/time --format="%e,%P,%M,%K" --append --output="logs/$iter-large-rw-dyn-mon.txt" java -Xss88M -cp ../../examples/target/scala-2.12/examples-assembly-0.0.3.jar examples.ftp.MonRunner 4021 4000 &
    /usr/bin/time --format="%e,%P,%M,%K" --append --output="logs/$iter-large-rw-dyn-client.txt" python3 client/tftp-client.py 4000 ${iter} rw large-test-file.txt
    sleep 5
done
