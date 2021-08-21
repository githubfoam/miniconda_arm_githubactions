ARG BASE_IMAGE
FROM ${BASE_IMAGE}

ARG QEMU_ARCH
ENV QEMU_ARCH=${QEMU_ARCH:-x86_64} 

COPY qemu/qemu-${QEMU_ARCH}-static /usr/bin/

RUN set -x && apk add --no-cache curl \
  && case "${QEMU_ARCH}" in \
    x86_64) MINICONDA_ARCH='amd64';; \
    arm) MINICONDA_ARCH='armhf';; \
    aarch64) MINICONDA_ARCH='aarch64';; \
    *) echo "unsupported architecture"; exit 1 ;; \
  esac \
  && $MINICONDA_ARCH

ENTRYPOINT [ "/init" ]
