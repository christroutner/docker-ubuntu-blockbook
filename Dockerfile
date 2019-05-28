#FROM fedora:29
FROM ubuntu:18.04
MAINTAINER Chris Troutner <chris.troutner@gmail.com>

RUN apt-get update -y

RUN apt-get install -y curl sudo

# Install Node.js
RUN curl -sL https://deb.nodesource.com/setup_10.x | sudo -E bash -
RUN sudo apt-get install -y nodejs build-essential
COPY dummyapp.js dummyapp.js

# Copy the pre-built .deb files
COPY debs/backend-bcash_0.19.6-satoshilabs-1_amd64.deb backend-bcash.deb
COPY debs/blockbook-bcash_0.3.0_amd64.deb blockbook-bcash.deb

# Install the debs
RUN apt install -y ./backend-bcash.deb
RUN apt install -y ./blockbook-bcash.deb

# Copy the config file
COPY blockchain_cfg.json /opt/coins/blockbook/bcash/config/blockchaincfg.json

# Copy the startup script
copy launch.sh launch.sh

#ENV TAG=master

# Install dependencies
#RUN dnf -y install which libstdc++-devel zeromq zeromq-devel gcc-c++ findutils libstdc++-static golang \
#                   snappy-devel zlib-devel bzip2-devel lz4-libs lz4-devel git && \
#	     	   dnf clean all

#RUN useradd -ms /bin/bash blockbook

#USER blockbook

#RUN  mkdir -p $HOME/rocksdb/include

#ENV HOME=/home/blockbook
#ENV GOPATH=$HOME/go
#ENV PATH="$PATH:$GOPATH/bin"

# Install go dep
#RUN mkdir -p $HOME/go && go get github.com/golang/dep/cmd/dep

# Install RocksDB and the Go wrapper

#ENV CGO_CFLAGS="-I/$HOME/rocksdb/include"
#ENV CGO_LDFLAGS="-L/$HOME/rocksdb -lrocksdb -lstdc++ -lm -lz -lbz2 -lsnappy -llz4"

#RUN cd /tmp && git clone https://github.com/facebook/rocksdb.git && cd rocksdb \
#&& CFLAGS=-fPIC CXXFLAGS=-fPIC make release && \
#cp librock* $HOME/rocksdb && cp -r include $HOME/rocksdb && \
#cd $HOME && rm -Rf /tmp/rocksdb && \
#go get github.com/tecbot/gorocksdb

# Build Blockbook
#RUN cd $GOPATH/src && git clone https://github.com/trezor/blockbook.git && \
#cd blockbook && git checkout $TAG && dep ensure -vendor-only && \
#BUILDTIME=$(date --iso-8601=seconds); GITCOMMIT=$(git describe --always --dirty); \
#LDFLAGS="-X blockbook/common.version=${TAG} -X blockbook/common.gitcommit=${GITCOMMIT} -X blockbook/common.buildtime=${BUILDTIME}" && \
#go build -ldflags="-s -w ${LDFLAGS}" && rm -Rf /home/blockbook/go/pkg/dep/sources

# Copy startup scripts
#COPY launch.sh $HOME

#COPY blockchain_cfg.json $HOME/cfg.json

EXPOSE 9030 9130

VOLUME /opt/coins/data/bcash/blockbook/db

#ENTRYPOINT $HOME/launch.sh

CMD node dummyapp.js
