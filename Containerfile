# syntax=docker/dockerfile:1.7
ARG BASE="ghcr.io/ublue-os/bazzite-deck:stable"
FROM ${BASE}

COPY build_files/ /tmp/build_files/
COPY packages/ /tmp/packages/

RUN bash /tmp/build_files/build.sh && \
    rm -rf /var/* /tmp/* && \
    ostree container commit
