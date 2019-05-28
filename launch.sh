#!/bin/bash

# Blockbook must be run from this directory
cd /opt/coins/blockbook/bcash

# Start blockbook
/opt/coins/blockbook/bcash/bin/blockbook -blockchaincfg=/opt/coins/blockbook/bcash/config/blockchaincfg.json \
-datadir=/opt/coins/data/bcash/blockbook/db -sync -internal=:9031 -public=:9131 \
-certfile=/opt/coins/blockbook/bcash/cert/blockbook -explorer= -log_dir=/opt/coins/blockbook/bcash/logs -workers=1

