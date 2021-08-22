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

export BRANCH_NAME="main"
echo "BRANCH_NAME is..: $BRANCH_NAME"

echo $(if [ "$BRANCH_NAME" = "master" ]; then if [ "$TAG_SUFFIX" = "" ]; then echo "latest";fi; fi)
export TARGET_IMAGE_TAG=$(if [ "$BRANCH_NAME" = "main" ]; then if [ "$TAG_SUFFIX" = "" ]; then echo "latest";fi; fi)

echo "TAG_SUFFIX is..: $TAG_SUFFIX"
echo "TARGET_IMAGE_TAG is..: $TARGET_IMAGE_TAG"
# echo $IMAGE_CACHE

docker pull $TARGET_IMAGE:$TARGET_IMAGE_TAG && export IMAGE_CACHE="--cache-from $TARGET_IMAGE:$TARGET_IMAGE_TAG" || export IMAGE_CACHE=""

docker build . -f $DOCKERFILE $IMAGE_CACHE --build-arg BASE_IMAGE=${BASE_IMAGE} --build-arg QEMU_ARCH=${QEMU_ARCH} -t $TARGET_IMAGE:$TARGET_IMAGE_TAG

# docker image ls

echo "========================================================================================="
