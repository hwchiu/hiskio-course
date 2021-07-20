#####
FROM ubuntu:16.04

RUN apt-get update && \
        apt-get install -y --no-install-recommends nginx=1.10.3* && \
        apt-get clean &&\
        rm -rf /var/lib/apt/lists/*

ARG HASH
ARG LOG
ENV COMMITHASH=$HASH
ENV COMMITLOG=$LOG

COPY entrypoint.sh ./
ENTRYPOINT ["/bin/bash", "./entrypoint.sh"]
