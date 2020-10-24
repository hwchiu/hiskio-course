
#!/bin/bash

cleanup() {
    echo "Cleaning up..."
    exit
}

trap cleanup INT TERM

while :; do
    echo "Hello! ${SECONDS} secs elapsed..."
    sleep 1s
done
