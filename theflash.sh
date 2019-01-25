#!/bin/bash

query="$1"
db="$2"
format="$3"

set -eu

source ./_env.sh

if [ -z "$db" ]; then
	db="default"
fi

if [ ! -z "$format" ]; then
	format="-f $format"
fi

if [ -z "$query" ]; then
	"$bin" client --host=$host --port=$port -d $db
else
	"$bin" client --host=$host --port=$port -d $db --query="$query" $format
fi
