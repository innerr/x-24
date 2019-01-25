#!/bin/bash

table="$1"
blocks="$2"
check="$3"

set -eu
set -o pipefail

source ./_env.sh

if [ -z "$table" ]; then
	echo "usage: <bin> table-name [blocks-number=1], [check-after-load=true]" >&2
	exit 1
fi

if [ -z "$blocks" ]; then
	blocks="1"
fi

if [ -z "$check" ]; then
	check="true"
fi

mkdir -p "./tmp/schema"
file="./tmp/schema/$table.ddl.${scale}"

echo "CREATE DATABASE IF NOT EXISTS tpch${scale};" > "$file"
echo "USE tpch${scale};" >> "$file"
echo "" >> "$file"
if [ "$use_pk" == "true" ]; then
	cat ./$schema/$table.pk.ddl >> "$file"
else
	cat ./$schema/$table.ddl >> "$file"
fi

mysql -h $mysql_host -P $mysql_port -u root < "$file"

if [ "$blocks" == "1" ]; then
	file="$data/tpch${scale}/$table.tbl"
	mysql -h $mysql_host -P $mysql_port -u root -D tpch${scale} \
		-e "load data local infile '$file' into table $table fields terminated by '|' lines terminated by '|\n';"
else
	for ((i=1; i<$blocks+1; ++i)); do
		file="$data/tpch${scale}_${blocks}/$table.tbl.$i"
		mysql -h $mysql_host -P $mysql_port -u root -D tpch${scale} \
			-e "load data local infile '$file' into table $table fields terminated by '|' lines terminated by '|\n';" &
	done
	wait
fi

if [ "$check" == "true" ]; then
	for ((i=0; i<$scale; ++i)); do
		sleep 3
	done
	./check.sh $table
fi
