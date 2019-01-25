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

for ((i=0;i<$cores;++i)); do
    #echo "partition: ${i}"
    ./theflash.sh "selraw count(*) from tpch${scale}.${table} partition('$i')"
    ./theflash.sh "select count(*) from tpch${scale}.${table} partition('$i')"
    echo '...'
done
