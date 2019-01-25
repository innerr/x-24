#!/bin/bash

set -eu
set -o pipefail

cd ../raft-scripts
./monitor.sh
