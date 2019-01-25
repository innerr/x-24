#!/bin/bash

table="$1"

set -eu
source ./_env.sh

if [ -z "$table" ]; then
	echo "usage: <bin> table-name" >&2
	exit 1
fi

m=`./mysql.sh "SELECT count(1) FROM tpch${scale}.${table}" | tail -n 1`
t=`./theflash.sh "SELECT count(1) FROM tpch${scale}.${table}"`
w=`wc -l "$data/tpch${scale}/$table.tbl" | awk '{print $1}'`

if [ "$m" != "$t" ]; then
	echo "mysql($m) != theflash($t)" >&2
	exit 1
fi
if [ "$w" != "$t" ]; then
	echo "file lines($w) != theflash($t)" >&2
	exit 1
fi
