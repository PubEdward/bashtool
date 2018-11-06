#!/bin/bash

source iniparser.sh

read-ini /etc/ceph/test.conf;
result=$(get-cfg global "enable experimental unrecoverable data corrupting features");
echo $result;

put-cfg global "enable experimental unrecoverable data corrupting features" "bluestore testval";
write-ini /etc/ceph/test.conf;
