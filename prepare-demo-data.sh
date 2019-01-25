#!/bin/bash

set -eu
set -o pipefail

echo "=> ./load.sh partsupp"
./load.sh partsupp
echo "=> ./load.sh lineitem"
./load.sh lineitem

./optimize.sh partsupp
./optimize.sh lineitem
