FROM ubuntu:20.04
ARG ARG
# Build essential pkg-config
RUN apt-get update && apt-get install -y build-essential autoconf libtool git
#RUN apt-get install -y pkg-config

# Default installation
RUN if [ "$arg" = "default" ] ; then \
    apt-get install -y cmake ; fi
    
# Version 3.17.0
RUN if [ "x$arg" = "x" ] ; then \
    apt-get install -y wget ; wget https://github.com/Kitware/CMake/releases/download/v3.17.0/cmake-3.17.0-Linux-x86_64.sh -O cmake-install.sh ; \
    sh cmake-install.sh --prefix=/usr/local/ --exclude-subdir ; fi

# Creating dev user
RUN useradd -ms /bin/bash -d /home/dev dev

# gRPC version 1.35.0
RUN git clone --recurse-submodules -b v1.35.0 https://github.com/grpc/grpc
RUN mkdir /home/dev/.local
RUN [ "/bin/bash", "-c", "cd grpc ; mkdir -p cmake/build && pushd cmake/build && \
    cmake -DgRPC_INSTALL=ON \
    -DgRPC_BUILD_TEST=OFF \
    -DCMAKE_INSTALL_PREFIX=/home/dev/.local \
    ../.. && \
    make -j4 && make install && popd" ]

# Setting up the development environment
RUN echo 'PATH=$PATH:/home/dev/.local/bin' > /root/.bashrc
RUN echo 'PATH=$PATH:/home/dev/.local/bin' > /home/dev/.bashrc
USER dev
WORKDIR /home/dev/
CMD [ "tail", "-f", "/dev/null" ]
