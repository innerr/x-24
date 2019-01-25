#!/bin/bash

table="$1"

set -eu
set -o pipefail

source ./_env.sh

if [ -z "$table" ]; then
	echo "usage: <bin> table-name" >&2
	exit 1
fi

config="../raft-scripts/config/config.xml"
cores=`cat "$config" | grep mutable_mergetree_partition_number | awk -F '>' '{print $2}' | awk -F '<' '{print $1}'`

for ((j=0;j<1;++j)); do
	for ((i=0;i<$cores;++i)); do
		echo ./theflash.sh "optimize table tpch${scale}.${table} partition id '$i' final eliminate"
		./theflash.sh "optimize table tpch${scale}.${table} partition id '$i' final eliminate"
	done
done
