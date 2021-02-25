FROM ubuntu:20.04
# Default installation
RUN apt-get update && apt-get install -y build-essential
RUN apt-get install -y cmake
RUN apt-get install -y wget
# Boost Version 1.70
RUN wget https://dl.bintray.com/boostorg/release/1.70.0/source/boost_1_70_0.tar.bz2
RUN bzip2 -d boost_1_70_0.tar.bz2
RUN tar xf boost_1_70_0.tar
# Boost default installation
RUN cd /boost_1_70_0 && ./bootstrap.sh && ./b2 install
# Setting up the development environment
RUN useradd -ms /bin/bash -d /home/dev dev
USER dev
WORKDIR /home/dev/
CMD [ "tail", "-f", "/dev/null" ]