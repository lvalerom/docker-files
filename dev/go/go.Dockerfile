FROM ubuntu
RUN apt-get update
RUN apt-get -y install wget
RUN apt-get -y install git
RUN apt-get -y install autoconf automake libtool make g++ unzip
RUN useradd -ms /bin/bash -d /home/dev dev 
RUN mkdir /home/dev/go
RUN chown dev:dev /home/dev/go
# Go installation
RUN wget https://dl.google.com/go/go1.11.5.linux-amd64.tar.gz
RUN tar -C /usr/local -xzf /go1.11.5.linux-amd64.tar.gz
RUN rm /go1.11.5.linux-amd64.tar.gz
RUN echo 'PATH=$PATH:/usr/local/go/bin:/home/dev/go/bin \
	\nexport GOPATH=/home/dev/go' > /root/.bashrc
RUN echo 'PATH=$PATH:/usr/local/go/bin:/home/dev/go/bin \
	\nexport GOPATH=/home/dev/go' > /home/dev/.bashrc
# Setting up the development environment
USER dev
RUN mkdir -p /home/dev/go/src/dev
WORKDIR /home/dev/go/src/dev
CMD [ "tail", "-f", "/dev/null" ]