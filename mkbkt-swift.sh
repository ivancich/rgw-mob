#!/bin/bash

authurl="http://192.168.140.134:8080/auth"
user="janedoe:swift"
key="E9T2rUZNu2gxUjcwUBO8n/Ev4KX6/GprEuH4qhu1"

if [ $# -lt 1 ] ;then
    echo "Usage: $0 bucket-name ..."
    exit 1
fi

for b in $* ;do
    echo "creating bucket $b"
    swift --auth $authurl -U "$user" -K "$key" post "$b"
done

echo done
