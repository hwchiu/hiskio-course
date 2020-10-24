FROM ubuntu:16.04
MAINTAINER hwchiu@linkernetworks.com

RUN apt-get update && \
	apt-get install -y net-tools \
    git 

COPY entrypoint.bash ./
ENTRYPOINT ["/bin/bash", "./entrypoint.bash"]
