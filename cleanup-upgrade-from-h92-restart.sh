#!/bin/bash

set -eu
set -o pipefail

cd ../raft-scripts
./stop_all.sh

cd ..
./theflash-upgrade-bin-from-h92.sh

cd raft-scripts
./run_all.sh true

cd ../tpch-scripts
