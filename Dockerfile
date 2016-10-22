FROM    ubuntu:16.04

RUN apt-get update -qq

RUN apt-get install -y automake \
    autoconf \
    pkg-config \
    libcurl4-openssl-dev \
    libjansson-dev \
    libssl-dev \
    libgmp-dev \
    libzthread-dev \
    build-essential \
    gcc \
    g++ \
    git



RUN git clone https://github.com/JayDDee/cpuminer-opt.git

WORKDIR /cpuminer-opt
RUN ./autogen.sh
RUN CFLAGS="-O3 -march=native -DROW_PREFETCH -Wall -mavx2 -funroll-loops -ftree-vectorize -fuse-linker-plugin -fvariable-expansion-in-unroller -ftree-loop-if-convert-stores -fmerge-all-constants" CXXFLAGS="$CFLAGS -std=gnu++11 -lm -lpthread" ./configure --with-curl  --with-crypto  && make

ENTRYPOINT ["./cpuminer"]

