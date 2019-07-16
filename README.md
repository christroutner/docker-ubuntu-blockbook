## docker-ubuntu-blockbook

This repository contains code to build a Docker container that runs an instance
of the [Blockbook](https://github.com/trezor/blockbook) indexer, customized for
the Bitcoin Cash (BCH) network.

This Docker container depends
on [this fork of Blockbook](https://github.com/christroutner/blockbook) which
generates the `.deb` files in the the [debs](debs) directory. Copies of these
files are included with this repository, but if you need updated installation
files, then you need to build them with that fork of Blockbook. The .deb files
are targeted for Ubuntu 18.04 running on an amd64 architecture.

## Installation
This installation targets Ubuntu 18.04 running on an amd64 architecture. Your
mileage may vary.

- The first step is to ensure you have fully-synced BCH full node running with
an RPC interace exposed and `txindex=1` set in its `bitcoin.conf` file. Once
you've met that prerequisite, edit the [blockchain_cfg.json](blockchain_cfg.json)
file with the RPC connection details.

- Ensure you have Docker and Docker Compose installed.
[Here is information](http://troutsblog.com/research/dev-ops/overview) on how
to install that software on Ubuntu.

- Clone this repository and enter the directory it creates:

`git clone https://github.com/christroutner/docker-ubuntu-blockbook && cd docker-ubuntu-blockbook`

- Build the image by running `docker-compose build`.

- Run Blockbook with `docker-compose up -d`

## Usage
This container configures Blockbook to run as a single-threaded process. This is
the only way to ensure that Blockbook does not corrupt its own database, which it
has a tendency to do when running in multithreaded mode. This will make the initial
sync pretty slow. When fully synced, Blockbook will consume over *130 GB* of data.

- Data is saved in the [data](data) directory.

- Logs are saved in the [logs](logs) directory. Logs can be monitored with this
command: `tail -f logs/blockbook.INFO`

- Blockbook status can also be monitored by going to `https://localhost:9130`

- A list of gotchas and other information about running
Blockbook [can be found here](https://troutsblog.com/research/bitcoin-cash/blockbook)

## Troubleshooting
- If the docker container exits with the error: `Illegal instruction     (core dumped)`,
it means the Debian files need to be updated for your computer. Regenerate them
with [this fork of Blockbook](https://github.com/christroutner/blockbook) and
copy the generated `.deb` files into the [debs](./debs) folder and rebuild the
container.

## License
[MIT](LICENSE.md)
