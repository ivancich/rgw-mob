This repo contains files useful for exercising RGW on a cluster.

This could be better generalized. Currently the assumptions are that
we have two client nodes and three rgw-client nodes.

    #rgws
    192.168.140.134	client-000
    192.168.136.91	client-001
    192.168.205.149	client-002

    #clients
    192.168.174.32	client-003
    192.168.202.103	client-004

The doad3 tool, originally written by Marcus Watts and edited by Eric
Ivancich, is necessary. Please get the version in the repo:

    https://github.com/ivancich/doad-fork.git

The doad3 tool must be built for the platform the clients (client-003,
client-004) are running on. The version in this repo was built on:

    Linux client-003 4.4.0-36-generic #55-Ubuntu SMP Thu Aug 11
    18:01:55 UTC 2016 x86_64 x86_64 x86_64 GNU/Linux

Prior to running the test, a user is created "janedoe" and a swift
user is created "janedoe:swift". This can be done by running the
create-user.sh script on an appropriate node. (Note: remove-user.sh
also exixts.)

At that point the orchestrate.sh script can be run on the "jump
host". It will:

  a. copy necessary scripts, data files and executables to client-003
     and client-004,

  b. have them each create appropriate buckets, and

  c. run the doad3 executable on each multiple times in the background
     to perform the actual test

Here's what's actually run:

1. On each client, we run three instances of doad3, each targeting one
   of the three rgw clients, each using its own bucket.

2. The doad3 instances create and remove 100,000 objects using 10
   threads. The create and remove commands are randomized, the only
   guarantee being that an object is removed only after it's
   created. So there can theoretically be between 0 and 100,000
   objects in the bucket at any given time. The command sequencing is
   generated from Marcus Watts's rndrw.pl script.

3. So that's six instances of doad3, and each rgw client is targeted
   by two. This is the background traffic to create load for the
   following attempt to create the customer issue.

4. Each client runs one more instance of doad3 which repeatedly
   creates and removes the same object 100,000 times. Each of these
   clients uses the same bucket "bktff" (to hit the same bucket index
   node) but a different rgw client (client-000 and client-001 but not
   client-002). Each client manipulates its own unique object in a
   single thread ("flipflop_3" and "flipflop_4").
