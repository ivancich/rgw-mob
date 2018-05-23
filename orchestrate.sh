#!/bin/bash

client_list="client-003 client-004"
rgw0="client-000:8080"
rgw1="client-001:8080"
rgw2="client-002:8080"
cfile="hundred_thousand_cmds.txt"

for c in $client_list ;do
    scp doad3 mkbkt-swift.sh clean-swift.sh launch-doad.sh \
	hundred_cmds.txt hundred_thousand_cmds.txt \
	flipflop_3_cmds.txt flipflop_4_cmds.txt \
	${c}:
done

for c in $client_list ;do
    ssh $c ./clean-swift.sh -a
    ssh $c ./mkbkt-swift.sh bkt3a bkt3b bkt3c bkt4a bkt4b bkt4c bktff
    break # only need to make buckets on first client
done

launch_doad() {
    if [ $# -ne 6 ] ;then
	echo "error: $0 had $# arguments instead of 6"
	exit 1
    fi
    client="$1"
    rgw="$2"
    bucket="$3"
    threads="$4"
    cmdfile="$5"
    logfile="$6"
    command="'nohup ./launch-doad.sh http://${rgw} ${bucket} ${threads} ${cmdfile} >${logfile} 2>&1 &'"

    set -x
    ssh -f ${client} "sh -c ${command}"
    set +x
}

if false ;then
    # launch a quick test
    launch_doad client-003 192.168.140.134:8080 bkt3a 10 \
	hundred_cmds.txt 3a.log
    exit 0
fi

launch_doad client-003 $rgw0 bkt3a 10 $cfile 3a.log
launch_doad client-003 $rgw1 bkt3b 10 $cfile 3b.log
launch_doad client-003 $rgw2 bkt3c 10 $cfile 3c.log

launch_doad client-004 $rgw0 bkt4a 10 $cfile 4a.log
launch_doad client-004 $rgw1 bkt4b 10 $cfile 4b.log
launch_doad client-004 $rgw2 bkt4c 10 $cfile 4c.log

launch_doad client-003 $rgw0 bktff 1 flipflop_3_cmds.txt 3ff.log
launch_doad client-004 $rgw0 bktff 1 flipflop_4_cmds.txt 4ff.log
