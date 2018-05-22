#!/bin/sh

scp doad3 mkbkt-swift.sh clean-swift.sh launch-doad.sh \
    induce_error_cmds.txt flipflop_3_cmds.txt flipflop_4_cmds.txt \
    client-003:

ssh client-003 ./mkbkt-swift.sh bkterr

ssh -f client-003 "sh -c 'nohup ./launch-doad.sh http://192.168.140.134:8080 bkterr 1 induce_error_cmds.txt >3mkerr.log 2>&1 &'"

# 192.168.140.134 client-000
# 192.168.136.91  client-001
# 192.168.205.149 client-002
