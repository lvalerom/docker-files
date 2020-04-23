FROM ubuntu
RUN apt-get update && apt-get -y install wget
RUN apt-get -y install git
RUN apt-get -y install autoconf automake libtool make g++ unzip
RUN useradd -ms /bin/bash -d /home/dev dev 
RUN mkdir /home/dev/go
RUN chown dev:dev /home/dev/go

# Go
RUN wget https://dl.google.com/go/go1.14.2.linux-amd64.tar.gz
RUN tar -C /usr/local -xzf /go1.14.2.linux-amd64.tar.gz
RUN rm /go1.14.2.linux-amd64.tar.gz
RUN echo 'PATH=$PATH:/usr/local/go/bin:/home/dev/go/bin \
	\nexport GOPATH=/home/dev/go' > /root/.bashrc
RUN echo 'PATH=$PATH:/usr/local/go/bin:/home/dev/go/bin \
	\nexport GOPATH=/home/dev/go' > /home/dev/.bashrc 

# Protobuf
RUN git clone https://github.com/protocolbuffers/protobuf.git
#RUN git --git-dir=/protobuf/.git --work-tree=/protobuf submodule update --init --recursive
RUN cd /protobuf && git submodule update --init --recursive
RUN cd /protobuf && ./autogen.sh && ./configure --prefix=/usr 
RUN make -C /protobuf 
RUN make check -C /protobuf
RUN make install -C /protobuf
USER dev

RUN /usr/local/go/bin/go get -u github.com/golang/protobuf/{proto,protoc-gen-go}

# Micro
RUN GO111MODULE=on /usr/local/go/bin/go get github.com/micro/micro/v2@v2.5.0
RUN GO111MODULE=on /usr/local/go/bin/go get github.com/micro/go-micro/v2@v2.5.0
RUN GO111MODULE=on /usr/local/go/bin/go get github.com/micro/micro/v2/cmd/protoc-gen-micro@master

# Kubernetes
RUN GO111MODULE=on /usr/local/go/bin/go get k8s.io/client-go@v0.17.0

# 
RUN /usr/local/go/bin/go get github.com/gin-gonic/gin
RUN /usr/local/go/bin/go get github.com/gin-contrib/cors
RUN /usr/local/go/bin/go get github.com/dgrijalva/jwt-go
RUN /usr/local/go/bin/go get github.com/satori/go.uuid
RUN /usr/local/go/bin/go get -u github.com/jinzhu/gorm
RUN /usr/local/go/bin/go get github.com/lib/pq
RUN /usr/local/go/bin/go get github.com/streadway/amqp

RUN mkdir /home/dev/go/src/dev
WORKDIR /home/dev/go
CMD [ "tail", "-f", "/dev/null" ]
