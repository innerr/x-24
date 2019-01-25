#!/bin/bash

table="$1"
client="$2"
selraw="$3"

set -eu
source ./_env.sh

if [ -z "$table" ]; then
	echo "usage: <bin> table-name" >&2
	exit 1
fi

if [ -z "$client" ]; then
	client="theflash"
fi

select="select"
if [ "$selraw" == "true" ]; then
	select="selraw"
fi

echo "=> ./${client}.sh $select count(1) from tpch${scale}.${table}"
./${client}.sh "$select count(1) from tpch${scale}.${table}"
