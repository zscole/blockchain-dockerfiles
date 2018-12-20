FROM ubuntu:latest

RUN apt-get update && apt-get -y upgrade
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y apt-utils ca-certificates gnupg openjdk-8-jdk curl git-all \
    software-properties-common build-essential rpm fakeroot openssh-server inetutils-tools 
RUN apt-get install -y --no-install-recommends prometheus

RUN apt-get install -y --no-install-recommends python-pip python-setuptools &&\
    pip install gcredstash

# clones required repos
RUN git clone https://github.com/rchain/rchain.git \
    && git clone https://github.com/BNFC/bnfc

# installs haskell
RUN curl -sSL https://get.haskellstack.org/ | bash
RUN stack upgrade
RUN apt-get install -y jflex haskell-platform

# installs SBT
RUN curl -L -o sbt-1.2.6.deb https://dl.bintray.com/sbt/debian/sbt-1.2.6.deb \
    && dpkg -i sbt-1.2.6.deb \
    && rm sbt-1.2.6.deb \
    && apt-get update \
    && apt-get install -y sbt

# installs BNFC
WORKDIR /bnfc
RUN git checkout b0252e5f666ed67a65b6e986748eccbfe802bc17
RUN stack init \
    && stack setup \
    && stack install
ENV PATH="/root/.local/bin:${PATH}"

# build rchain
WORKDIR /rchain
RUN sbt clean bnfc:clean bnfc:generate rholang/bnfc:generate rholang/compile rholangCLI/assembly \
    comm/compile clean rholang/bnfc:generate casper/test:compile node/rpm:packageBin \
    node/debian:packageBin node/universal:packageZipTarball

ENV PATH="/rchain/node/target/rnode-0.7.1/usr/share/rnode/bin/:${PATH}"

ENTRYPOINT /bin/bash -c "export SSH_PRIVATE_KEY=\"$(gcredstash --keyring-id whiteblock --key-id whiteblock --project-id wb-genesis get customers/rchain/SSH_PRIVATE_KEY)\""