#!/bin/sh

if [ $# -ne 4 ] ;then
    echo "Usage: $0 rgwurl bucket threads infile"
    exit 1
fi

rgw="$1"
bucket="$2"
threads="$3"
infile="$4"

./doad3 -u janedoe:swift -p E9T2rUZNu2gxUjcwUBO8n/Ev4KX6/GprEuH4qhu1 \
    -h "$rgw" -s 4096 -t "$threads" -b "$bucket" <"$infile"

rgw="http://192.168.140.134:8080"
