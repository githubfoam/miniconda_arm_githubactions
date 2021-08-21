#!/bin/bash
set -o errexit
set -o pipefail
set -o nounset
set -o xtrace
# set -eox pipefail #safety for script

echo "========================================================================================="

export BASE_IMAGE=arm64v8/alpine 
export QEMU_ARCH=aarch64 
export DOCKERFILE="Dockerfile" 
export TAG_SUFFIX="aarch64"

echo $BASE_IMAGE $QEMU_ARCH $DOCKERFILE $TAG_SUFFIX

sudo apt-get --yes --no-install-recommends install binfmt-support qemu-user-static

docker run --rm --privileged multiarch/qemu-user-static:register --reset

docker build . -f $DOCKERFILE $IMAGE_CACHE --build-arg BASE_IMAGE=${BASE_IMAGE} --build-arg QEMU_ARCH=${QEMU_ARCH} -t $TARGET_IMAGE:$TARGET_IMAGE_TAG

docker image ls

echo "========================================================================================="