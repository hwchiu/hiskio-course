#####
FROM ubuntu:16.04

RUN apt-get update && \
        apt-get install -y nginx

ARG HASH
ARG LOG
ENV COMMITHASH=$HASH
ENV COMMITLOG=$LOG

COPY entrypoint.sh ./
ENTRYPOINT ["/bin/bash", "./entrypoint.sh"]
