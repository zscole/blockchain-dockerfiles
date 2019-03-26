FROM ubuntu:18.04
	
RUN apt-get update && \ 
	DEBIAN_FRONTEND=noninteractive apt-get install -y build-essential maven libsodium-dev \
    tmux wget iperf3 curl apt-utils iputils-ping expect npm git git-extras \
    software-properties-common

# install java
RUN echo oracle-java8-installer shared/accepted-oracle-license-v1-1 select true | debconf-set-selections && \
	add-apt-repository -y ppa:webupd8team/java && \
	apt-get update && \
	apt-get install -y oracle-java8-installer && \
	rm -rf /var/lib/apt/lists/* && \
	rm -rf /var/cache/oracle-jdk8-installer 
ENV JAVA_HOME="/usr/lib/jvm/java-8-oracle"

# get pantheon
RUN git clone --recursive https://github.com/PegaSysEng/pantheon.git
WORKDIR /pantheon
RUN ./gradlew build -x test
WORKDIR /pantheon/build/distributions
RUN tar -xzf pantheon-1.0.2-SNAPSHOT.tar.gz
ENV PATH="/pantheon/build/distributions/pantheon-1.0.2-SNAPSHOT/bin:${PATH}"
WORKDIR /

ENTRYPOINT ["/bin/bash"]


