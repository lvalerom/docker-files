FROM ubuntu
ARG ARG
# Build essential
RUN apt-get update && apt-get install -y build-essential

# Default installation
RUN if [ "$arg" = "default" ] ; then \
    apt-get install -y cmake ; fi
    
# Version 3.16.0
RUN if [ "x$arg" = "x" ] ; then \
    apt-get install -y wget ; wget https://github.com/Kitware/CMake/releases/download/v3.16.0-rc2/cmake-3.16.0-rc2-Linux-x86_64.sh -O cmake-install.sh ; \
    sh cmake-install.sh --prefix=/usr/local/ --exclude-subdir ; fi

# Setting up the development environment
RUN useradd -ms /bin/bash -d /home/dev dev
USER dev
WORKDIR /home/dev/
CMD [ "tail", "-f", "/dev/null" ]