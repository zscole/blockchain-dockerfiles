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

RUN rustup update stable
RUN rustup update nightly
RUN rustup target add wasm32-unknown-unknown --toolchain nightly
RUN cargo +nightly install --git https://github.com/alexcrichton/wasm-gc
RUN git clone https://github.com/paritytech/shasper.git
WORKDIR /shasper
RUN apt-get -y install clang
ENV TERM linux
RUN bash -c "chmod +x build.sh"
RUN bash -c "./build.sh"
RUN cargo run -- --dev

EXPOSE 8080 8545 8180

ENTRYPOINT ["/bin/bash"]

## target/debug/shapser --dev