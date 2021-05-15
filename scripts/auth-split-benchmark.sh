#!/usr/bin/env bash

iterations=(100 200 300 400 500 600 700 800 900 1000 1500 2000 2500 3000 3500 4000 4500 5000 5500 6000 6500 7000 7500 8000 8500 9000 9500 10000)

echo "Starting seq analyzer config connect_and_auth"
for iter in "${iterations[@]}"; do
    /usr/bin/time --format="%e,%P,%M,%K" --output="authlogs/$iter-auth-split-server.txt" java -Xss16M -cp ../examples/target/scala-2.12/examples-assembly-0.0.3.jar examples.splitauth.ServerRunner ${iter} &
    /usr/bin/time --format="%e,%P,%M,%K" --output="authlogs/$iter-auth-split-smon.txt" java -Xss116M -cp ../examples/target/scala-2.12/examples-assembly-0.0.3.jar examples.splitauth.ServerMonRunner ${iter} &
    /usr/bin/time --format="%e,%P,%M,%K" --output="authlogs/$iter-auth-split-cmon.txt" java -Xss116M -cp ../examples/target/scala-2.12/examples-assembly-0.0.3.jar examples.splitauth.ClientMonRunner ${iter} &
    /usr/bin/time --format="%e,%P,%M,%K" --output="authlogs/$iter-auth-split-client.txt" python3 auth-client.py 1330 1335 ${iter} authlogs/time/${iter}-split-rt-1.txt
    sleep 5
    /usr/bin/time --format="%e,%P,%M,%K" --append --output="authlogs/$iter-auth-split-server.txt" java -Xss16M -cp ../examples/target/scala-2.12/examples-assembly-0.0.3.jar examples.splitauth.ServerRunner ${iter} &
    /usr/bin/time --format="%e,%P,%M,%K" --append --output="authlogs/$iter-auth-split-smon.txt" java -Xss116M -cp ../examples/target/scala-2.12/examples-assembly-0.0.3.jar examples.splitauth.ServerMonRunner ${iter} &
    /usr/bin/time --format="%e,%P,%M,%K" --append --output="authlogs/$iter-auth-split-cmon.txt" java -Xss116M -cp ../examples/target/scala-2.12/examples-assembly-0.0.3.jar examples.splitauth.ClientMonRunner ${iter} &
    /usr/bin/time --format="%e,%P,%M,%K" --append --output="authlogs/$iter-auth-split-client.txt" python3 auth-client.py 1330 1335 ${iter} authlogs/time/${iter}-split-rt-2.txt
    sleep 5
    /usr/bin/time --format="%e,%P,%M,%K" --append --output="authlogs/$iter-auth-split-server.txt" java -Xss16M -cp ../examples/target/scala-2.12/examples-assembly-0.0.3.jar examples.splitauth.ServerRunner ${iter} &
    /usr/bin/time --format="%e,%P,%M,%K" --append --output="authlogs/$iter-auth-split-smon.txt" java -Xss116M -cp ../examples/target/scala-2.12/examples-assembly-0.0.3.jar examples.splitauth.ServerMonRunner ${iter} &
    /usr/bin/time --format="%e,%P,%M,%K" --append --output="authlogs/$iter-auth-split-cmon.txt" java -Xss116M -cp ../examples/target/scala-2.12/examples-assembly-0.0.3.jar examples.splitauth.ClientMonRunner ${iter} &
    /usr/bin/time --format="%e,%P,%M,%K" --append --output="authlogs/$iter-auth-split-client.txt" python3 auth-client.py 1330 1335 ${iter} authlogs/time/${iter}-split-rt-3.txt
    sleep 5
done
