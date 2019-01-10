FROM ubuntu:18.04

# builds without UI elements by default
# remove `-DBEAM_NO_QT_UI_WALLET=On` to build with UI

ARG b=testnet4_cpu_mining
ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get -y update && apt-get -y upgrade
RUN apt-get -y install software-properties-common
RUN add-apt-repository ppa:ubuntu-toolchain-r/test && apt-get update
RUN apt-get install -y apt-utils ca-certificates curl git-all cmake build-essential \
    vim inetutils-tools wget libboost-all-dev libssl-dev libdrm-dev g++ gcc ping

RUN git clone https://github.com/BeamMW/beam
WORKDIR /beam
RUN git checkout $b && cmake -DCMAKE_BUILD_TYPE=RELEASE -DBEAM_NO_QT_UI_WALLET=On . && make -j8

ENV PATH="/beam/beam/:/beam/wallet/:${PATH}"

ENTRYPOINT ["/bin/bash"]
