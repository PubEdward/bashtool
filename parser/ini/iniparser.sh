#!/bin/bash

declare -A conf;
declare -a order;
read-ini(){
	confile=$1
	while read line
	do
		if [[ $line =~ ^[:blank:]*[^\;] ]]; then
			if [[ $line =~ \[.*\] ]]; then
				line=${line#\[};
				line=${line%\]};
				cur=$line-_-;
			else
				key=`echo $line | cut -d '=' -f 1`;
				key=${key% };
				val=`echo $line | cut -d '=' -f 2`;
				val=${val# };
				key="$cur""$key"
				order[${#order[@]}]="$key";
				conf["$key"]="$val";
			fi
		fi
	done < $confile
}

write-ini(){
	num=${#order[@]};
	declare cursection;
	cat /dev/null > $1;
	for ((i=0; i<num;i++)){
		mapkey=${order[$i]}
		section=$mapkey;
		key=$mapkey;
		section=${section/-_-*/};
		key=${key/*-_-/};
		if [[ $section != $cursection ]]; then
			cursection=$section;
			cat >> $1 <<EOF

[$section]
EOF
		fi
		cat >> $1 <<EOF
	$key = ${conf[$mapkey]}
EOF
	}
}

get-cfg(){
	section=$1;
	key=$2;
	section=$section-_-
	echo ${conf[$section$key]};
}

put-cfg(){
	section=$1;
	key=$2;
	val=$3;
	section=$section-_-
	conf[$section$key]="$val"
}
