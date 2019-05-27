#!/bin/bash

# workers=1 prevents accidents with the database:
# https://github.com/trezor/blockbook/issues/89#issuecomment-442252741

#docker container run -v $PWD/cfg:/home/blockbook/cfg -w=/home/blockbook/go/src/blockbook \
#-v /home/safeuser/blockbook-docker/data:/home/blockbook/go/src/blockbook/data \
#-p 9130:9130 -p 9030:9030 --name dev-bb --restart=always -d \
#--entrypoint=/home/blockbook/go/src/blockbook/blockbook dev-bb \
#-sync -blockchaincfg=/home/blockbook/cfg.json -workers=1 -logtostderr

docker container run --rm -d dev-bb
