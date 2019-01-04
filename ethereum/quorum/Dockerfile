FROM ubuntu:latest
	
RUN apt-get update &&\ 
	DEBIAN_FRONTEND=noninteractive apt-get install -y build-essential maven libsodium-dev tmux \
	apt-utils iputils-ping expect npm git git-extras software-properties-common golang-go

# install java
RUN echo oracle-java8-installer shared/accepted-oracle-license-v1-1 select true | debconf-set-selections && \
	add-apt-repository -y ppa:webupd8team/java && \
	apt-get update && \
	apt-get install -y oracle-java8-installer && \
	rm -rf /var/lib/apt/lists/* && \
	rm -rf /var/cache/oracle-jdk8-installer
ENV JAVA_HOME="/usr/lib/jvm/java-8-oracle"

# get geth
RUN add-apt-repository -y ppa:ethereum/ethereum &&\ 
	apt update &&\ 
	apt-get install -y ethereum

# build quorum
RUN git clone https://github.com/jpmorganchase/quorum
WORKDIR /quorum
RUN make
ENV PATH="${PWD}=${PATH}"

# build tessera
WORKDIR /
RUN git clone https://github.com/jpmorganchase/tessera && git checkout tessera-0.7.3
WORKDIR /tessera
RUN mvn install -DskipTests
ENV PATH="${PWD}=${PATH}"

# add examples
WORKDIR /
RUN git clone https://github.com/jpmorganchase/quorum-examples

ENTRYPOINT ["/bin/bash"]
