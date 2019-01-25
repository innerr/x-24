#!/bin/bash

set -eu
set -o pipefail

source ./_env.sh
cd ../raft-scripts
source ./_check.sh

show_partitions "../theflash-newest" "lineitem" "tpch${scale}"
show_partitions "../theflash-newest" "partsupp" "tpch${scale}"
show_partitions "../theflash-newest" "usertable" "test"
