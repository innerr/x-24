#!/bin/bash

table="$1"
detail="$2"

set -eu
source ./_env.sh

if [ -z "$table" ]; then
	echo "usage: <bin> table-name" >&2
	exit 1
fi
if [ -z "$detail" ]; then
	detail="false"
fi

echo "=> check_partition(tpch${scale}, $table, $detail)"
./dbg-invoke.sh "check_partition(tpch${scale}, $table, $detail)"

echo "=> select count(*) from tpch${scale}.$table"
./theflash.sh "select count(*) from tpch${scale}.$table"

echo "=> scan_partition(tpch${scale}, $table, $detail)"
./dbg-invoke.sh "scan_partition(tpch${scale}, $table)"

echo "=> check_region_correct(tpch${scale}, $table, $detail)"
./dbg-invoke.sh "check_region_correct(tpch${scale}, $table)"
