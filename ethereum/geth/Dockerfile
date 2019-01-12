FROM ubuntu:latest 

ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update &&\ 
	apt-get install -y apt-utils iputils-ping expect git git-extras software-properties-common tmux vim \
	inetutils-tools wget ca-certificates curl build-essential libssl-dev golang-go make iperf3 openssh-server 

# builds out geth
RUN git clone https://github.com/zscole/go-ethereum
WORKDIR /go-ethereum
RUN make all
WORKDIR /

# sets up eth net intelligence api & dependencies
RUN apt-get install -f -y npm nodejs
RUN git clone -b master https://bitbucket.org/whiteblockio/eth-net-intelligence-api.git 
WORKDIR	/eth-net-intelligence-api 
RUN	npm install && npm install -g pm2
WORKDIR /

ENV PATH /go-ethereum/build/bin:${PATH}

ENTRYPOINT ["/bin/bash"]
