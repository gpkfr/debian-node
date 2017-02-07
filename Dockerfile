FROM debian:jessie-slim

ENV VERSION=v7.5.0

RUN apt-get update && \
  apt-get install -qq -y  curl \
    gnupg && \
  gpg --keyserver ha.pool.sks-keyservers.net --recv-keys \
    9554F04D7259F04124DE6B476D5A82AC7E37093B \
    94AE36675C464D64BAFA68DD7434390BDBE9B9C5 \
    0034A06D9D9B0064CE8ADF6BF1747F4AD2306D93 \
    FD3A5288F042B6850C66B31F09FE44734EB7990E \
    71DCFD284A79C3B38668286BC97EC7A07EDE3FC1 \
    DD8F2338BAE7501E3DD5AC78C273792F7D83545D \
    C4F0DFFF4E8C1A8236409D08E73BC641CC11F4C8 \
    B9AE9905FFD7803F25714661B63B535A4C206CA9 && \
  curl -o node-${VERSION}-linux-x64.tar.gz -sSL https://nodejs.org/dist/${VERSION}/node-${VERSION}-linux-x64.tar.gz && \
  curl -o SHASUMS256.txt.asc -sSL https://nodejs.org/dist/${VERSION}/SHASUMS256.txt.asc && \
  gpg --verify SHASUMS256.txt.asc && \
  grep node-${VERSION}-linux-x64.tar.gz SHASUMS256.txt.asc | sha256sum -c - && \
  cd /usr/local && \
  tar -zxf /node-${VERSION}-linux-x64.tar.gz -C /usr/local --strip-components=1 && \
  cd / && \
  apt-get purge -y --auto-remove curl \
    make \
    gcc \
    g++ \
    python \
    linux-headers-amd64 && \
    rm -rf /etc/ssl /node-${VERSION}-linux-x64.tar.gz /SHASUMS256.txt.asc\
    /usr/share/man /tmp/* /root/.npm /root/.node-gyp /root/.gnupg \
    /usr/local/lib/node_modules/npm/man /usr/local/lib/node_modules/npm/doc /usr/local/lib/node_modules/npm/html && \
  apt-get clean && \
  rm -rf /var/lib/apt/lists/*
