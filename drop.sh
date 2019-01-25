#!/bin/bash

table="$1"

set -eu
source ./_env.sh

if [ -z "$table" ]; then
	echo "usage: <bin> table-name" >&2
	exit 1
fi

./mysql.sh "DROP TABLE IF EXISTS tpch${scale}.${table}"
