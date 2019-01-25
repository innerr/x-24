#!/bin/bash

func="$1"
pretty="$2"

set -eu
source ./_env.sh

if [ -z "$func" ]; then
	echo "usage: <bin> function-call [pretty=true]"
fi
if [ -z "$pretty" ]; then
	pretty="true"
fi

fmt=""
if [ "$pretty" == "true" ]; then
	fmt="PrettyCompactNoEscapes"
fi
./theflash.sh "DBGInvoke $func" "default" #$fmt
