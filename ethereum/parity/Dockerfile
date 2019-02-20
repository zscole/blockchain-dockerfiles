FROM rust:1.32.0-stretch as built

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update && apt-get install \
    -y --no-install-recommends \
    apt-utils iputils-ping expect git git-extras yasm curl \
    software-properties-common tmux gcc libudev-dev pkg-config \
    file make g++ \
    wget ca-certificates cmake \
    iperf3 openssh-server telnet iproute2 libssl-dev \
    && apt-get clean  

RUN git clone https://github.com/paritytech/parity-ethereum
WORKDIR /parity-ethereum
RUN git checkout stable
RUN cargo clean && cargo build --release --features final

RUN echo "export PATH=\"/parity-ethereum/target/release:\${PATH}\"" >> /etc/profile
ENV PATH="/parity-ethereum/target/release:${PATH}"

EXPOSE 8080 8545 8180

FROM debian:stretch as final

RUN apt-get update && apt-get install -y  vim iperf3 openssh-server telnet iproute2 libssl-dev iputils-ping
COPY --from=built /parity-ethereum/target/release/parity /usr/local/bin/parity

ENTRYPOINT ["/bin/bash"]
