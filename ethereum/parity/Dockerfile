FROM ubuntu:latest

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update &&\ 
	apt-get install -y --no-install-recommends \
    apt-utils iputils-ping expect npm git git-extras yasm curl \
    software-properties-common tmux gcc libudev-dev pkg-config \
    file make g++ g++-arm-linux-gnueabihf libc6-dev-armhf-cross \
    wget ca-certificates binutils-arm-linux-gnueabihf cmake \
    && apt-get clean

RUN curl https://sh.rustup.rs -sSf | sh -s -- -y
ENV PATH="/root/.cargo/bin:${PATH}"
ENV RUST_TARGETS="arm-unknown-linux-gnueabihf"

RUN git clone https://github.com/paritytech/parity-ethereum
WORKDIR /parity-ethereum
RUN git checkout stable
RUN cargo clean && cargo build --release --features final

ENV PATH="/parity-ethereum/target/release:${PATH}"

EXPOSE 8080 8545 8180

ENTRYPOINT ["/bin/bash"]
