FROM ubuntu

RUN apt-get update && apt-get install -y git wget
RUN apt-get install -y build-essential autoconf libtool gfortran
RUN apt-get install -y libreadline-dev libncurses-dev libexpat1-dev libgsl0-dev libboost-dev libcmocka-dev
RUN apt-get install -y libcfitsio-dev wcslib-dev

RUN mkdir -p /sirena/
WORKDIR /sirena

# RUN wget https://heasarc.gsfc.nasa.gov/FTP/software/lheasoft/lheasoft6.26/updates/heasoft-6.26.1src_patch.tar.gz
# RUN tar xvzf heasoft-6.26.1src_patch.tar.gz

RUN git clone http://www.sternwarte.uni-erlangen.de/git.public/simput.git/
RUN git clone http://www.sternwarte.uni-erlangen.de/git.public/sixt/

RUN mkdir -p /sirena/sim
RUN mkdir -p /sirena/six

RUN cd /sirena/simput && autoreconf -fvi && ./configure --prefix=/sirena/sim && make && make install
RUN cd /sirena/sixt && autoreconf -fvi && ./configure --prefix=/sirena/six --with-simput=/sirena/sim && make && make install

RUN printf 'export SIMPUT=/sirena/sim\nexport SIXTE=/sirena/six\n${SIXTE}/bin/sixte-install.sh' >> /root/.bashrc

RUN git clone https://github.com/bcobo/SIRENACobo.git

CMD [ "tail", "-f", "/dev/null" ]