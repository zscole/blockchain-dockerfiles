FROM ubuntu:latest
	
RUN apt-get update &&\ 
	apt-get install -y openjdk-8-jdk build-essential maven libsodium-dev tmux \
	apt-utils iputils-ping expect npm git git-extras software-properties-common 

RUN add-apt-repository -y ppa:ethereum/ethereum &&\ 
	apt update &&\ 
	apt-get install -y ethereum

RUN git clone https://github.com/jpmorganchase/quorum
WORKDIR /quorum
RUN make
ENV PATH=${PWD}=${PATH}

WORKDIR /
RUN git clone https://github.com/jpmorganchase/tessera
WORKDIR /tessera
RUN mvn install
ENV PATH=${PWD}=${PATH}

WORKDIR /
RUN git clone https://github.com/jpmorganchase/quorum-examples

ENTRYPOINT ["/bin/bash"]
