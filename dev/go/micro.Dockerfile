FROM ubuntu
RUN apt-get update
RUN apt-get -y install wget
RUN apt-get -y install git
RUN apt-get -y install autoconf automake libtool make g++ unzip
RUN useradd -ms /bin/bash -d /home/dev dev 
RUN mkdir /home/dev/go
RUN chown dev:dev /home/dev/go
RUN wget https://dl.google.com/go/go1.11.5.linux-amd64.tar.gz
RUN tar -C /usr/local -xzf /go1.11.5.linux-amd64.tar.gz
RUN rm /go1.11.5.linux-amd64.tar.gz
RUN echo 'PATH=$PATH:/usr/local/go/bin:/home/dev/go/bin \
	\nexport GOPATH=/home/dev/go' > /root/.bashrc
RUN echo 'PATH=$PATH:/usr/local/go/bin:/home/dev/go/bin \
	\nexport GOPATH=/home/dev/go' > /home/dev/.bashrc 
RUN git clone https://github.com/protocolbuffers/protobuf.git
#RUN git --git-dir=/protobuf/.git --work-tree=/protobuf submodule update --init --recursive
RUN cd /protobuf && git submodule update --init --recursive
RUN cd /protobuf && ./autogen.sh && ./configure --prefix=/usr 
RUN make -C /protobuf 
RUN make check -C /protobuf
RUN make install -C /protobuf
USER dev
RUN /usr/local/go/bin/go get -u github.com/golang/protobuf/proto
RUN /usr/local/go/bin/go get -u github.com/golang/protobuf/protoc-gen-go
RUN /usr/local/go/bin/go get github.com/micro/protoc-gen-micro
#RUN /usr/local/go/bin/go get github.com/micro/go-micro
RUN /usr/local/go/bin/go get -u github.com/micro/micro
RUN /usr/local/go/bin/go get github.com/gin-gonic/gin
RUN /usr/local/go/bin/go get github.com/micro/go-web
RUN /usr/local/go/bin/go get k8s.io/client-go/...
# RUN /usr/local/go/bin/go get github.com/go-sql-driver/mysql
# RUN /usr/local/go/bin/go get github.com/jmoiron/sqlx
RUN mkdir /home/dev/go/src/dev
RUN mkdir /home/dev/go/src/sep
WORKDIR /home/dev/go
CMD [ "tail", "-f", "/dev/null" ]