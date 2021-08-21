#!/bin/bash
set -o errexit
set -o pipefail
set -o nounset
set -o xtrace
# set -eox pipefail #safety for script

echo "========================================================================================="
sudo apt-get --yes --no-install-recommends install binfmt-support qemu-user-static

docker build -t arm32v7/debian:stretch-slim-conda . --file Dockerfile.arm32v7.conda

docker run arm32v7/debian:stretch-slim-conda conda info
docker image ls

echo "========================================================================================="
