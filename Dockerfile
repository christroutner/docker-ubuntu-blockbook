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

EXPOSE 9030 9130

VOLUME /opt/coins/data/bcash/blockbook/db
VOLUME /opt/coins/blockbook/bcash/logs

ENTRYPOINT $HOME/launch.sh

#CMD node dummyapp.js
