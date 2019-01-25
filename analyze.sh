#!/bin/bash

table="$1"

set -eu
source ./_env.sh

if [ -z "$table" ]; then
	echo "usage: <bin> table-name" >&2
	exit 1
fi

storage_server_config=`readlink -f "../raft-scripts/config/config.xml"`

cd ../theflash-newest

./analyze-table-compaction.sh "$table" "tpch${scale}"
