#!/bin/bash

authurl="http://192.168.140.134:8080/auth"
user="janedoe:swift"
key="E9T2rUZNu2gxUjcwUBO8n/Ev4KX6/GprEuH4qhu1"

if [ $# -lt 1 ] ;then
    echo "Usage: $0 [-a] [bucket-name ...]"
    echo "    Either use -a to clean all buckets or provide a list of bucket names."
    exit 1
fi

if [ "$1" == "-a" ] ;then
    # list buckets
    buckets=$(swift --auth $authurl -U "$user" -K "$key" list)
    if [ -z "$buckets" ] ;then
	echo "no buckets; done"
	exit 0
    fi
    echo buckets: $buckets
else
    buckets="$*"
fi

# for b in $buckets ;do
for b in $buckets ;do
    echo "cleaning bucket $b"
    # delete bucket
    swift --auth $authurl -U "$user" -K "$key" delete "$b"
done

echo done

exit 0

# OLDER, SLOWER CODE BELOW

# for b in $buckets ;do
for b in $buckets ;do
    echo "cleaning bucket $b"
    # list bucket
    objects=$(swift --auth $authurl -U "$user" -K "$key" list "$b")
    for o in $objects ;do
	# delete each object
	swift --auth $authurl -U "$user" -K "$key" delete "$b" "$o"
    done
    # delete bucket
    swift --auth $authurl -U "$user" -K "$key" delete "$b"
done

echo done
