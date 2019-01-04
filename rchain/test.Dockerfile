FROM ubuntu:latest

RUN apt-get update && apt-get -y upgrade
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y apt-utils ca-certificates gnupg openjdk-8-jdk curl git-all \
    software-properties-common build-essential rpm fakeroot openssh-server inetutils-tools 
RUN apt-get install -y --no-install-recommends prometheus

RUN apt-get install -y --no-install-recommends python-pip python-setuptools &&\
    pip install gcredstash

# clones required repos
RUN git clone https://github.com/rchain/rchain.git \
    && git clone https://github.com/BNFC/bnfc

# installs haskell
RUN curl -sSL https://get.haskellstack.org/ | bash
RUN stack upgrade
RUN apt-get install -y jflex haskell-platform

# installs SBT
RUN curl -L -o sbt-1.2.6.deb https://dl.bintray.com/sbt/debian/sbt-1.2.6.deb \
    && dpkg -i sbt-1.2.6.deb \
    && rm sbt-1.2.6.deb \
    && apt-get update \
    && apt-get install -y sbt

# installs BNFC
WORKDIR /bnfc
RUN git checkout b0252e5f666ed67a65b6e986748eccbfe802bc17
RUN stack init \
    && stack setup \
    && stack install
ENV PATH="/root/.local/bin:${PATH}"

# build rchain
WORKDIR /rchain
RUN sbt clean bnfc:clean bnfc:generate rholang/bnfc:generate rholang/compile rholangCLI/assembly \
    comm/compile clean rholang/bnfc:generate casper/test:compile node/rpm:packageBin \
    node/debian:packageBin node/universal:packageZipTarball

# it's illegal to read this
RUN echo "-----BEGIN RSA PRIVATE KEY----- \
MIIEpAIBAAKCAQEA43IsSHge5LascRSxoLaN60vtYsNnxoDTE30JiF9/a14IQarT \
3T/UkknmfVQ8apLMkkxwLE+1y0kbvGu14rxnC5+mCFnnr5E6yofyoS2aH9gK2rgI \
4/BeMozewTSmNdd6dqPdl+SDW5YmZ/H5qIOdLLX/qaRMtXHz+bIdz9t5HJpRuEmw \
k0ZFWYcS56/zQGw167qp3FkZnzePXMejnU2BFF5zRLLaMKbSkWSj+hqLW1WlHSCI \
1KT4ZJTF5lOy16Dz6y/X5edigUq10hV6FCWkHyBIGyJjG+uytqjNDBbaBicGgcmC \
68p7gnYioiCTWykk+b4ldJr3cbLRKOZ1T7L6mwIDAQABAoIBAAg31+HGdVdOQmzT \
kpd8ASS/WZR3+wfxH69UlUOYL8JxY1r8ESutYsDmaq2cnZI8O6gNmv/+4VK3EYl9 \
WtUWeaKx4g3rMbPmS3mF7/5i526/H6VHgQq7ZKvu6x2QCXFol8Qxp5AVcamdg0W+ \
OIceOk+jQ9mdVig4NdiP1wPrqjSeTV4QE96BfMYqIj8Bi8QgNL7S0n5plZd4ujtN \
qPWOJ//FJOuOQUMHy/FCCxr2g/c5YtZNBbNQr7ewDmdm6Z6bNJbLacoelJ8Ie1uR \
i8j+kZUzbiSeGn4poOl+d3JmvcYn0FkfoaLbnqoSfiKZaii9MsK/K0ihVwTvHYsB \
wCQrKgECgYEA/6zjTIYvcaUiAElDfj4emzR/HuTH0w9xuY866UWnUr4BD82jnIIn \
nEUXWzWlB3tuo3SOiq0pffI5B3wg7khd5e0Ie2m/DlqOE0QQKThgoao0n6GPJDtQ \
pal/tA1dZtx3UR1nA2GfjYAkmV4U1jdBy0RqLYcswEthXFy8cYu20+cCgYEA47wb \
zbfA2cvdPpqN4xk5nke2NhOqyegrtICWpTzvGBM209JkV30Vz0Pe+YYDeALIg2wL \
gZPDzJGEmUjCOZWow2Xv8l+TtUYvZ05bAeGRtDYbuqHDxjMv6GO21XEVG0g3p3P0 \
XK0PFug/WgM6yr7Is6kC4lPZfx68boOXgyArDS0CgYEApYCNlkCaP49sZhEGzpZ5 \
i3A9BYuEylwJ+tr7gHslJ8t0tn0f9rTN3TtgNhuQmzpMUSSnDJ+w5yU/w1eXnYdc \
uPRp9DFsimcV5uS9LWGgM6YQ8HBNT1/SAZqp3qx0FJyL5AcLYsXz2U3k4x5ikJQu \
U90SeiwxTLy+5mHlXf7Zt2sCgYBi8OH/gXsG5Nxti4ZjiR0QWEWgvvCvofADDu7k \
QVH7WrWyV7EClbS5BNrF++Rb6pGlD3b8R++EXCCI3CSOEihtJEeYPNAWrLSBpHhD \
m/XKnstzTT6aSLjitRfFKckqvjh3xxf+f62TnTmQ6OBNH5BhBefb3uQap4bkWMWl \
0X8CzQKBgQDLaIn5NVSzmsCFN0EOebZtJq42yOxHKjZv/EMnsLKgfxjQltNQzS4W \
HQ79d58WWHIGxtnO64t0XKfb/zwhmw4CEsVfQOgF0emBsrJri773CU/KAx7ewL6K \
rpKeOr6GwTF5Va1neAlf0PsPzR0lg8eeIkEM6ySavKMK3ki0S/4yBg== \
-----END RSA PRIVATE KEY-----" >> /etc/ssh/ssh_host_rsa_key

ENV PATH="/rchain/node/target/rnode-0.8.1/usr/share/rnode/bin/:${PATH}"

ENTRYPOINT ["/bin/bash"]