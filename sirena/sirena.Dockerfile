FROM ubuntu

RUN apt-get update && apt-get install -y git wget
RUN apt-get install -y build-essential autoconf libtool gfortran xorg-dev
RUN apt-get install -y libreadline-dev libncurses-dev libexpat1-dev libgsl0-dev libboost-dev libcmocka-dev
RUN apt-get install -y libcfitsio-dev wcslib-dev

RUN mkdir -p /sirena/
WORKDIR /sirena

RUN wget https://heasarc.gsfc.nasa.gov/cgi-bin/Tools/tarit/tarit.pl?mode=download&arch=src&src_pc_linux_ubuntu=Y&src_other_specify=&checkeverything=on&checkallmission=on&mission=asca&mission=einstein&mission=exosat&mission=gro&mission=heao1&mission=hitomi&mission=integral&mission=maxi&mission=nicer&mission=nustar&mission=oso8&mission=rosat&mission=suzaku&mission=swift&mission=vela5b&mission=xte&checkallgeneral=on&general=attitude&general=caltools&general=futils&general=fimage&general=heasarc&general=heasim&general=heasptools&general=heatools&general=heagen&general=fv&general=timepkg&checkallxanadu=on&xanadu=ximage&xanadu=xronos&xanadu=xspec&xstar=xstar
RUN tar xvzf heasoft-6.26.1src.tar.gz

RUN cd /sirena/heasoft-6.26.1/BUILD_DIR && ./configure && make && make install

RUN printf '\nexport HEADAS=/sirena/heasoft-6.26.1/x86_64-pc-linux-gnu-libc2.27\nsource $HEADAS/headas-init.sh' >> /root/.bashrc
RUN printf '\nexport PFILES="/tmp/$$.tmp/pfiles;$HEADAS/syspfiles"' >> /root/.bashrc

RUN git clone http://www.sternwarte.uni-erlangen.de/git.public/simput.git/
RUN git clone http://www.sternwarte.uni-erlangen.de/git.public/sixt/

RUN mkdir -p /sirena/sim
RUN mkdir -p /sirena/six

RUN cd /sirena/simput && autoreconf -fvi && ./configure --prefix=/sirena/sim && make && make install
RUN cd /sirena/sixt && autoreconf -fvi && ./configure --prefix=/sirena/six --with-simput=/sirena/sim && make && make install

RUN printf '\nexport SIMPUT=/sirena/sim\nexport SIXTE=/sirena/six\n${SIXTE}/bin/sixte-install.sh' >> /root/.bashrc

RUN git clone https://github.com/bcobo/SIRENACobo.git

CMD [ "tail", "-f", "/dev/null" ]
