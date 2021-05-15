#!/usr/bin/env bash

iterations=(100 200 300 400 500 600 700 800 900 1000 1500 2000 2500 3000 3500 4000 4500 5000 5500 6000 6500 7000 7500 8000 8500 9000 9500 10000)

echo "Starting control config connect_and_auth"
for iter in "${iterations[@]}"; do
    /usr/bin/time --format="%e,%P,%M,%K" --output="authlogs/$iter-auth-server.txt" java -Xss16M -cp ../examples/target/scala-2.12/examples-assembly-0.0.3.jar examples.auth.ServerRunner ${iter} &
    /usr/bin/time --format="%e,%P,%M,%K" --output="authlogs/$iter-auth-client.txt" python3 auth-client.py 1330 ${iter} authlogs/time/${iter}-rt-1.txt
    sleep 5
    /usr/bin/time --format="%e,%P,%M,%K" --append --output="authlogs/$iter-auth-server.txt" java -Xss16M -cp ../examples/target/scala-2.12/examples-assembly-0.0.3.jar examples.auth.ServerRunner ${iter} &
    /usr/bin/time --format="%e,%P,%M,%K" --append --output="authlogs/$iter-auth-client.txt" python3 auth-client.py 1330 ${iter} authlogs/time/${iter}-rt-2.txt
    sleep 5
    /usr/bin/time --format="%e,%P,%M,%K" --append --output="authlogs/$iter-auth-server.txt" java -Xss16M -cp ../examples/target/scala-2.12/examples-assembly-0.0.3.jar examples.auth.ServerRunner ${iter} &
    /usr/bin/time --format="%e,%P,%M,%K" --append --output="authlogs/$iter-auth-client.txt" python3 auth-client.py 1330 ${iter} authlogs/time/${iter}-rt-3.txt
    sleep 5
done
echo "Starting partial-id config connect_and_auth"
for iter in "${iterations[@]}"; do
    /usr/bin/time --format="%e,%P,%M,%K" --output="authlogs/$iter-auth-dyn-server.txt" java -Xss16M -cp ../examples/target/scala-2.12/examples-assembly-0.0.3.jar examples.auth.ServerRunner ${iter} &
    /usr/bin/time --format="%e,%P,%M,%K" --output="authlogs/$iter-auth-dyn-mon.txt" java -Xss116M -cp ../examples/target/scala-2.12/examples-assembly-0.0.3.jar examples.auth.MonRunner ${iter} &
    /usr/bin/time --format="%e,%P,%M,%K" --output="authlogs/$iter-auth-dyn-client.txt" python3 auth-client.py 1335 ${iter} authlogs/time/${iter}-dyn-rt-1.txt
    sleep 5
    /usr/bin/time --format="%e,%P,%M,%K" --append --output="authlogs/$iter-auth-dyn-server.txt" java -Xss16M -cp ../examples/target/scala-2.12/examples-assembly-0.0.3.jar examples.auth.ServerRunner ${iter} &
    /usr/bin/time --format="%e,%P,%M,%K" --append --output="authlogs/$iter-auth-dyn-mon.txt" java -Xss116M -cp ../examples/target/scala-2.12/examples-assembly-0.0.3.jar examples.auth.MonRunner ${iter} &
    /usr/bin/time --format="%e,%P,%M,%K" --append --output="authlogs/$iter-auth-dyn-client.txt" python3 auth-client.py 1335 ${iter} authlogs/time/${iter}-dyn-rt-2.txt
    sleep 5
    /usr/bin/time --format="%e,%P,%M,%K" --append --output="authlogs/$iter-auth-dyn-server.txt" java -Xss16M -cp ../examples/target/scala-2.12/examples-assembly-0.0.3.jar examples.auth.ServerRunner ${iter} &
    /usr/bin/time --format="%e,%P,%M,%K" --append --output="authlogs/$iter-auth-dyn-mon.txt" java -Xss116M -cp ../examples/target/scala-2.12/examples-assembly-0.0.3.jar examples.auth.MonRunner ${iter} &
    /usr/bin/time --format="%e,%P,%M,%K" --append --output="authlogs/$iter-auth-dyn-client.txt" python3 auth-client.py 1335 ${iter} authlogs/time/${iter}-dyn-rt-3.txt
    sleep 5
done
