FROM ubuntu:18.04

ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get -y update && apt-get -y upgrade
RUN apt-get -y install software-properties-common \
    build-essential libssl-dev vim inetutils-tools \
    curl git-all wget git-all 

RUN add-apt-repository ppa:longsleep/golang-backports
RUN apt-get update && apt-get -y install golang-go

RUN git clone https://github.com/storj/storj.git
WORKDIR /storj
RUN go install -v ./cmd/...

ENV PATH="/root/go/bin:${PATH}"

ENTRYPOINT ["/bin/bash"]