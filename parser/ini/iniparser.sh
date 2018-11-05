#!/bin/bash

declare -A conf;
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
				conf["$cur""$key"]="$val";
			fi
		fi
	done < $confile
}

get-cfg(){
	section=$1;
	key=$2;
	section=$section-_-
	echo ${conf[$section$key]};
}
