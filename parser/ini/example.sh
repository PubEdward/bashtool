#!/bin/bash

source iniparser.sh

read-ini /etc/ceph/ceph.conf;
result=$(get-cfg global "enable experimental unrecoverable data corrupting features");
echo $result;
