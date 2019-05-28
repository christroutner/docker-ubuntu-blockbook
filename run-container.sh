#!/bin/bash

# This script starts the Blockbook indexer inside the Docker container.

docker container run -d --name dev-bb \
-v /home/safeuser/docker-ubuntu-blockbook/data:/opt/coins/data/bcash/blockbook/db \
-v /home/safeuser/docker-ubuntu-blockbook/logs:/opt/coins/blockbook/bcash/logs \
-p 9130:9130 -p 9030:9030 \
--restart=always \
dev-bb
