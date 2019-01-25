#!/bin/bash

table="tpch50.lineitem"
partitions="40"

exp_col="l_comment"
exp_value="test"

# =-----------------------

function scan_id()
{
	local id="$1"
	local out="$2"
	local in_p="$out/in-p.$id"
	rm -f "$in_p"
	for ((i=0;i<$partitions;i++)); do
		./theflash.sh "selraw $i, _tidb_rowid, _INTERNAL_VERSION, _INTERNAL_DELMARK from $table \
			partition('$i') where _tidb_rowid = $id" >> "$in_p"
	done
	local p=`cat "$in_p" | awk '{print $1}' | sort | uniq`
	local c=`echo "$p" | wc -l`
	if [ "$c" != "1" ]; then
		echo "$id in more than one partitions:" > "$out/status.$id"
		echo "$p" >> "$out/status.$id"
		return
	fi
	./theflash.sh "selraw $p, _tidb_rowid, $exp_col, _INTERNAL_VERSION, _INTERNAL_DELMARK from $table \
		partition('$p')" | grep $id -A 10 -B 10 > "$out/status.$id"
	./theflash.sh "selraw $p, _tidb_rowid, $exp_col, _INTERNAL_VERSION, _INTERNAL_DELMARK from $table \
		partition('$p')" | grep "$exp_val" -A 20 -B 20 > "$out/updated-rows.p-$p"
}

out="scan-`date +%s`"
out="scan-result"
mkdir -p "$out"

echo "=> result: $out"

echo "=> scan extra rows"
#./theflash.sh "select _tidb_rowid, count(_tidb_rowid) from $table group by _tidb_rowid" | \
#	awk '{if ($2 > 1) print $0}' > "$out/extra"

cat "$out/extra" | awk '{print $1}' | while read id; do
	scan_id "$id" "$out"
	break
done
