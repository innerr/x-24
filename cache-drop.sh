#!/bin/bash

free -h
echo 1 > /proc/sys/vm/drop_caches
free -h
