FROM ubuntu
#RUN apt-get update && apt-get install -y --no-install-recommends apt-utils
# Repositories version
#RUN apt-get -y install nodejs npm
# v10
RUN apt-get update && apt-get -y install curl
RUN curl -sL https://deb.nodesource.com/setup_10.x | bash -
RUN apt-get -y install nodejs
# Install angularjs
RUN npm install -g @angular/cli
# Setting up the development environment
RUN useradd -ms /bin/bash -d /home/dev dev
USER dev
# README
RUN echo 'Create container with: \n\n \
    $ docker run -dit --name NAME -v ~/your/code/path:/home/dev/workspace -p 0.0.0.0:8080:4200 angular:latest \n\n \
    $ docker exec -it NAME bash \n\n \
    $ ng new my-app \n \
    $ cd my-app \n\n \
Change serve host to 0.0.0.0 in the angular.json config file \n\n \
    $ ng serve' > /home/dev/README
# Material dependencies installation script
RUN echo '#!/bin/bash \n \
npm install --save @angular/material @angular/cdk @angular/animations hammerjs' > /home/dev/install-dependencies.sh
RUN chmod +x /home/dev/install-dependencies.sh
# Setting up the workspace
RUN mkdir /home/dev/workspace
WORKDIR /home/dev/workspace
CMD [ "tail", "-f", "/dev/null" ]
