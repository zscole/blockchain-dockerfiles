FROM ethereum/client-go

ADD ./genesis.json ./genesis.json
RUN geth init genesis.json

RUN echo HAILSATAN > ./password.txt && \
	geth account new --password ./password.txt > ./account.txt 
	
EXPOSE 30303 8545 8546 30301 30301/udp

ENTRYPOINT ["/bin/sh"]
