FROM ubuntu
RUN apt-get update
# Default installation
RUN apt-get install -y build-essential
RUN apt-get install -y cmake
# Setting up the development environment
RUN useradd -ms /bin/bash -d /home/dev dev
USER dev
WORKDIR /home/dev/
CMD [ "tail", "-f", "/dev/null" ]