FROM ubuntu:18.04

# builds without UI elements by default

ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get -y update && apt-get -y upgrade
RUN apt-get -y install software-properties-common
RUN apt-get -y install build-essential cmake pkg-config libboost-all-dev \
    libssl-dev libzmq3-dev libunbound-dev libsodium-dev libunwind8-dev \
    liblzma-dev libreadline6-dev libldns-dev libexpat1-dev doxygen graphviz \
    libpgm-dev vim inetutils-tools curl git-all wget

RUN git clone https://github.com/monero-project/monero.git
WORKDIR /monero
RUN git submodule init && git submodule update
RUN make

ENV PATH="/monero/build/Linux/master/release/bin:${PATH}"

ENTRYPOINT ["/bin/bash"]