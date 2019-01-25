#!/bin/bash

if [ -z "$1" ]; then
	mysql -h 127.0.0.1 -P 12490 -u root
else
	mysql -h 127.0.0.1 -P 12490 -u root -e "$@"
fi
