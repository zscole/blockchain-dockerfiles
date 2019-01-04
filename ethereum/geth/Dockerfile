FROM ubuntu:latest

RUN apt-get update && apt-get install -y \
	apt-utils iputils-ping expect npm git git-extras software-properties-common tmux

RUN add-apt-repository -y ppa:ethereum/ethereum &&\ 
	apt update &&\ 
	apt-get install -y ethereum

ENTRYPOINT ["/bin/bash"]
