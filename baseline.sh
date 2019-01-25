#!/bin/bash

set -eu
source ./_env.sh

echo "=> ./theflash.sh selraw avg(l_discount) from tpch${scale}.lineitem"
time ./theflash.sh "selraw avg(l_discount) from tpch${scale}.lineitem"
echo

echo "=> ./theflash.sh select avg(l_discount) from tpch${scale}.lineitem"
time ./theflash.sh "select avg(l_discount) from tpch${scale}.lineitem"
echo

echo "=> ./mysql.sh select avg(l_discount) from tpch${scale}.lineitem"
time ./mysql.sh "select avg(l_discount) from tpch${scale}.lineitem"
