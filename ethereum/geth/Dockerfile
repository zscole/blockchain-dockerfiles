FROM ubuntu:latest as base

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update &&\ 
	apt-get install -y apt-utils iputils-ping expect npm git git-extras software-properties-common tmux \
    vim inetutils-tools wget ca-certificates curl build-essential libssl-dev golang-go make

RUN git clone https://github.com/zscole/go-ethereum
WORKDIR /go-ethereum
RUN make all

ENTRYPOINT ["/bin/bash"]
