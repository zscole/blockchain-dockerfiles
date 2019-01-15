FROM ubuntu:18.04

RUN apt-get -y update && apt-get -y upgrade
RUN apt-get -y install software-properties-common apt-utils ca-certificates \
    curl git git-extras vim inetutils-tools wget libssl-dev iperf3 \
    openssh-server iputils-ping 

RUN mkdir beam

WORKDIR /beam
RUN wget http://builds.beam-mw.com/files/master/2019.01.15/Release/linux/beam-wallet-cli-1.0.4164.tar.gz -O - | tar -xz
RUN wget http://builds.beam-mw.com/files/master/2019.01.15/Release/linux/beam-node-1.0.4164.tar.gz -O - | tar -xz

ENV PATH=/beam:${PATH}

ENTRYPOINT ["/bin/bash"]
