#!/bin/sh

if true ;then
    curl -v -H "X-Auth-User: janedoe:swift" \
	 -H "X-Auth-Key: E9T2rUZNu2gxUjcwUBO8n/Ev4KX6/GprEuH4qhu1" \
	 http://192.168.140.134:8080/auth
else
    curl -v -H "X-Auth-User: janedoe:swift" \
	 -H "X-Auth-Key: E9T2rUZNu2gxUjcwUBO8n/Ev4KX6/GprEuH4qhu1" \
	 http://50.116.63.87:8080/auth
fi
