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

- Ensure you have Docker installed and then clone this repository and enter the
directory it creates.

- Build the image by running the `build-image.sh` shell script.

- Run Blockbook by running the `run-container.sh` shell script.

## Usage
This container configures Blockbook to run as a single-threaded process. This is
the only way to ensure that Blockbook does not corrupt its own database, which it
has a tendency to do when running in multithreaded mode. This will make the initial
sync pretty slow. When fully synced, Blockbook will consume about *130 GB* of data.

- Data is saved in the [data](data) directory.

- Logs are saved in the [logs](logs) directory. Logs can be monitored with this
command: `tail -f logs/blockbook.INFO`

- Blockbook status can also be monitored by going to `https://localhost:9130`

## License
[MIT](LICENSE.md)
