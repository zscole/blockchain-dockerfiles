FROM eosio/builder as builder

RUN apt-get update
RUN git clone https://github.com/EOSIO/eos.git 
WORKDIR /eos
RUN cmake -DBINARYEN_BIN=/eos/externals/binaryen/bin -DWASM_ROOT=/opt/wasm -DOPENSSL_ROOT_DIR=/usr/bin/openssl -DOPENSSL_LIBRARIES=/usr/lib/ssl -DBUILD_MONGO_DB_PLUGIN=true .
RUN make -j8
RUN make install

FROM ubuntu:18.04

RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get -y install openssl ca-certificates
COPY --from=builder /usr/local/eosio/bin/ /eosio/bin
COPY --from=builder /eos/contracts /  
ENV EOSIO_ROOT=/eosio
ENV PATH /opt/eosio/bin:${PATH}

CMD ["/bin/bash"]
