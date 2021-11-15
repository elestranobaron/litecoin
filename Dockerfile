FROM debian:11.1
COPY ./muscleupcoin.conf /root/.muscleupcoin/muscleupcoin.conf
COPY . /muscleupcoin
WORKDIR /muscleupcoin

#shared libraries and dependencies
RUN apt update
RUN apt-get install -y build-essential libtool autotools-dev automake pkg-config bsdmainutils python3
RUN apt-get install -y libssl-dev libevent-dev libboost-system-dev libboost-filesystem-dev libboost-chrono-dev libboost-test-dev libboost-thread-dev

#get add-apt-repository
RUN apt-get install software-properties-common

#wallet
RUN add-apt-repository ppa:bitcoin/bitcoin
RUN apt-get update
RUN apt-get install libdb4.8-dev libdb4.8++-dev

#build muscleupcoin source
RUN ./autogen.sh
RUN ./configure
RUN make
RUN make install
#open service port
EXPOSE 9999 19999
CMD ["muscleupcoind", "--printtoconsole"]
