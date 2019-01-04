FROM ubuntu:latest as base

RUN apt update && apt install -y apt-utils tzdata && apt install -y expect git git-extras software-properties-common tmux python3 make && \
    git clone https://github.com/ethresearch/sharding-p2p-poc.git

FROM golang:1.10.3-alpine AS builder
WORKDIR /go/src/github.com/ethresearch/sharding-p2p-poc
COPY --from=base /go/src/github.com/ethresearch/sharding-p2p-poc/
RUN apk add git python3 make && \
    go get -d -v . && \
    make deps && \
    go build -v -o main . 

FROM builder
COPY --from=builder /go/src/github.com/ethresearch/sharding-p2p-poc/main /main

EXPOSE 8369 8370

ENTRYPOINT ["/bin/bash"]