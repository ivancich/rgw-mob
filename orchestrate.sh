#!/bin/sh

scp doad3 mkbkt-swift.sh clean-swift.sh launch-doad.sh \
    hundred_thousand_cmds.txt flipflop_3_cmds.txt flipflop_4_cmds.txt \
    client-003:

scp doad3 mkbkt-swift.sh clean-swift.sh launch-doad.sh \
    hundred_thousand_cmds.txt flipflop_3_cmds.txt flipflop_4_cmds.txt \
    client-004:

ssh client-003 ./mkbkt-swift.sh bkt3a bkt3b bkt3c bktff
ssh client-004 ./mkbkt-swift.sh bkt4a bkt4b bkt4c

ssh -f client-003 "sh -c 'nohup ./launch-doad.sh http://192.168.140.134:8080 bkt3a 10 hundred_thousand_cmds.txt >3a.log 2>&1 &'"

ssh -f client-003 "sh -c 'nohup ./launch-doad.sh http://192.168.136.91:8080 bkt3b 10 hundred_thousand_cmds.txt >3b.log 2>&1 &'"

ssh -f client-003 "sh -c 'nohup ./launch-doad.sh http://192.168.205.149:8080 bkt3c 10 hundred_thousand_cmds.txt >3c.log 2>&1 &'"

ssh -f client-004 "sh -c 'nohup ./launch-doad.sh http://192.168.140.134:8080 bkt4a 10 hundred_thousand_cmds.txt >4a.log 2>&1 &'"

ssh -f client-004 "sh -c 'nohup ./launch-doad.sh http://192.168.136.91:8080 bkt4b 10 hundred_thousand_cmds.txt >4b.log 2>&1 &'"

ssh -f client-004 "sh -c 'nohup ./launch-doad.sh http://192.168.205.149:8080 bkt4c 10 hundred_thousand_cmds.txt >4c.log 2>&1 &'"

ssh -f client-003 "sh -c 'nohup ./launch-doad.sh http://192.168.140.134:8080 bktff 1 flipflop_3_cmds.txt >3ff.log 2>&1 &'"

ssh -f client-004 "sh -c 'nohup ./launch-doad.sh http://192.168.136.91:8080 bktff 1 flipflop_4_cmds.txt >4ff.log 2>&1 &'"


# 192.168.140.134 client-000
# 192.168.136.91  client-001
# 192.168.205.149 client-002
