FROM ubuntu

RUN apt-get update && apt-get install -y wget
# nodejs
RUN apt-get -y install curl
RUN curl -sL https://deb.nodesource.com/setup_10.x | bash -
RUN apt-get -y install nodejs
# Dependencies
RUN dpkg --add-architecture i386
RUN apt-get update && apt-get -y upgrade
RUN apt-get install -y lib32gcc1 lib32stdc++6 libcurl4-gnutls-dev:i386
RUN apt-get -y install lib32z1 lib32ncurses5 libbz2-1.0 libstdc++6:i386
RUN apt-get install -y g++
RUN apt-get install -y openjdk-8-jdk
RUN update-alternatives --config java
RUN useradd -ms /bin/bash -d /home/dev dev
RUN echo "export JAVA_HOME=$(update-alternatives --query javac | sed -n -e 's/Best: *\(.*\)\/bin\/javac/\1/p')" >> /root/.bashrc
RUN echo "export JAVA_HOME=$(update-alternatives --query javac | sed -n -e 's/Best: *\(.*\)\/bin\/javac/\1/p')" >> /home/dev/.bashrc
# android jdk
RUN wget https://dl.google.com/android/repository/sdk-tools-linux-4333796.zip
RUN apt-get install -y unzip
RUN mkdir -p /usr/local/android/sdk
RUN unzip /sdk-tools-linux-4333796.zip -d /usr/local/android/sdk
RUN rm /sdk-tools-linux-4333796.zip
RUN echo 'export ANDROID_HOME="/usr/local/android/sdk/"' >> /root/.bashrc
RUN echo 'export ANDROID_HOME="/usr/local/android/sdk/"' >> /home/dev/.bashrc
RUN echo 'PATH="${PATH}:${ANDROID_HOME}tools/:${ANDROID_HOME}platform-tools/"' >> /root/.bashrc
RUN echo 'PATH="${PATH}:${ANDROID_HOME}tools/:${ANDROID_HOME}platform-tools/"' >> /home/dev/.bashrc
RUN yes | /usr/local/android/sdk/tools/bin/sdkmanager --licenses
RUN /usr/local/android/sdk/tools/bin/sdkmanager "tools" "emulator" "platform-tools" "platforms;android-28" "build-tools;28.0.3" "extras;android;m2repository" "extras;google;m2repository" 
# nativescript
RUN npm install nativescript -g --unsafe-perm
# Setting up the development environment
USER dev
RUN mkdir -p /home/dev/workspace
WORKDIR /home/dev/workspace
CMD [ "tail", "-f", "/dev/null" ]