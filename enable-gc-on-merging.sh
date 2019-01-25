#!/bin/bash

enabled="$1"

set -eu
set -o pipefail

if [ -z "$enabled" ]; then
	echo "usage: <bin> enabled(true|false)" >&2
	exit 1
fi 

if [ "$enabled" == "true" ]; then
	echo "enable_history_gc: ignore, we don't use this anymore!!"
else
	./dbg-invoke.sh "enable_history_gc('$enabled', 'false')"
fi

