FROM ubuntu:latest 

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update &&\
    apt-get install -y apt-utils iputils-ping expect git git-extras \
    software-properties-common tmux vim inetutils-tools wget ca-certificates \
    curl build-essential libssl-dev iperf3 openssh-server

RUN wget https://github.com/eosio/eos/releases/download/v1.5.3/eosio_1.5.3-1-ubuntu-18.04_amd64.deb &&\
    apt install -y ./eosio_1.5.3-1-ubuntu-18.04_amd64.deb

ENTRYPOINT ["/bin/bash"]