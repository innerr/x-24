#!/bin/bash

table="$1"
selraw="$2"

set -eu
source ./_env.sh

if [ -z "$table" ]; then
	echo "usage: <bin> table-name [select-raw=false]" >&2
	exit 1
fi

cores=`grep 'model name' /proc/cpuinfo | wc -l`

select="select"
if [ "$selraw" == "true" ]; then
	select="selraw"
fi

echo "=> $select count(1) from tpch${scale}.${table} partition (i)"

for ((i = 0; i < $cores; ++i)); do
	rows=`./theflash.sh "$select count(1) from tpch${scale}.${table} partition ('$i')"`
	echo "partition#${i} ${rows}"
done | sort -nrk 2 | head
