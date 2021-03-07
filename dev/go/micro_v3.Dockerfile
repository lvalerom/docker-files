FROM ubuntu:20.04
RUN apt-get update && apt-get -y install wget
RUN apt-get -y install git
RUN apt-get -y install autoconf automake libtool make g++ unzip
RUN useradd -ms /bin/bash -d /home/dev dev 
RUN mkdir /home/dev/go
RUN chown dev:dev /home/dev/go
# Go installation
RUN wget https://dl.google.com/go/go1.16.linux-amd64.tar.gz
RUN tar -C /usr/local -xzf /go1.16.linux-amd64.tar.gz
RUN rm /go1.16.linux-amd64.tar.gz
RUN echo 'PATH=$PATH:/usr/local/go/bin:/home/dev/go/bin:/home/dev/.local/bin \
	\nexport GOPATH=/home/dev/go' > /root/.bashrc 
RUN echo 'PATH=$PATH:/usr/local/go/bin:/home/dev/go/bin:/home/dev/.local/bin \
	\nexport GOPATH=/home/dev/go' > /home/dev/.bashrc
# Protoc installation
RUN wget https://github.com/protocolbuffers/protobuf/releases/download/v3.15.1/protoc-3.15.1-linux-x86_64.zip
RUN unzip protoc-3.15.1-linux-x86_64.zip -d /home/dev/.local
RUN chown dev:dev -R /home/dev/.local
# Setting up the development environment
USER dev

#FROM lvalerom/protoc:3.15.1

RUN /usr/local/go/bin/go get google.golang.org/protobuf/cmd/protoc-gen-go@v1.25.0
# Micro
RUN /usr/local/go/bin/go get github.com/micro/micro/v3@v3.1.1
RUN /usr/local/go/bin/go get github.com/micro/micro/v3/cmd/protoc-gen-micro@v3.1.1

RUN mkdir /home/dev/go/src
WORKDIR /home/dev/go/src
CMD [ "tail", "-f", "/dev/null" ]
