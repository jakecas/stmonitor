#!/bin/bash

iterations=(1000 2000 3000 4000 5000 6000 7000 8000 9000 10000)

for iter in "${iterations[@]}"; do
    /usr/bin/time --format="%P,%M,%K" --output="logs/$iter-small-r-server.txt" python3 server/tftp-server.py &
    /usr/bin/time --format="%P,%M,%K" --output="logs/$iter-small-r-client.txt" python3 client/tftp-client.py 4021 ${iter} r small-test-file.txt
    sleep 5
done
for iter in "${iterations[@]}"; do
    /usr/bin/time --format="%P,%M,%K" --output="logs/$iter-small-w-server.txt" python3 server/tftp-server.py &
    /usr/bin/time --format="%P,%M,%K" --output="logs/$iter-small-w-client.txt" python3 client/tftp-client.py 4021 ${iter} w small-test-file.txt
    sleep 5
done
for iter in "${iterations[@]}"; do
    /usr/bin/time --format="%P,%M,%K" --output="logs/$iter-small-rw-server.txt" python3 server/tftp-server.py &
    /usr/bin/time --format="%P,%M,%K" --output="logs/$iter-small-rw-client.txt" python3 client/tftp-client.py 4021 ${iter} rw small-test-file.txt
    sleep 5
done
for iter in "${iterations[@]}"; do
    /usr/bin/time --format="%P,%M,%K" --output="logs/$iter-medium-r-server.txt" python3 server/tftp-server.py &
    /usr/bin/time --format="%P,%M,%K" --output="logs/$iter-medium-r-client.txt" python3 client/tftp-client.py 4021 ${iter} r medium-test-file.txt
    sleep 5
done
for iter in "${iterations[@]}"; do
    /usr/bin/time --format="%P,%M,%K" --output="logs/$iter-medium-w-server.txt" python3 server/tftp-server.py &
    /usr/bin/time --format="%P,%M,%K" --output="logs/$iter-medium-w-client.txt" python3 client/tftp-client.py 4021 ${iter} w medium-test-file.txt
    sleep 5
done
for iter in "${iterations[@]}"; do
    /usr/bin/time --format="%P,%M,%K" --output="logs/$iter-medium-rw-server.txt" python3 server/tftp-server.py &
    /usr/bin/time --format="%P,%M,%K" --output="logs/$iter-medium-rw-client.txt" python3 client/tftp-client.py 4021 ${iter} rw medium-test-file.txt
    sleep 5
done
