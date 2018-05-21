#!/bin/sh

radosgw-admin user create --uid=janedoe --display-name="Jane Doe" \
	      --access-key=11BS02LGFB6AL6H1ADMW \
	      --secret=vzCEkuryfn060dfee4fgQPqFrncKEIkh3ZcdOANY

radosgw-admin subuser create --uid janedoe --subuser=swift \
	      --display-name 'Jane Doe, Swift' \
	      --secret='E9T2rUZNu2gxUjcwUBO8n/Ev4KX6/GprEuH4qhu1' \
	      --key-type swift --access=full
