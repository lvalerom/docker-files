FROM ubuntu
RUN apt-get update && apt-get clean
RUN apt-get install -y gnupg gnupg2 gnupg1
RUN apt-get install -y x11vnc
RUN apt-get install -y xvfb
RUN apt-get install -y fluxbox
RUN apt-get install -y wget
RUN apt-get install -y wmctrl

RUN useradd -ms /bin/bash -d /home/dev dev

# Chrome
RUN wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add - \
    && echo "deb http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google.list
RUN apt-get update && apt-get -y install google-chrome-stable

COPY chrome-x11.sh /root/start-x11.sh
RUN chmod 0755 /root/start-x11.sh
RUN cp /root/start-x11.sh /home/dev/
RUN chown dev:dev /home/dev/start-x11.sh

USER dev

# docker run --name NAME -p 5900:5900 -e VNC_SERVER_PASSWORD=password --privileged image
CMD ["/bin/bash", "-c", "/home/dev/start-x11.sh" ]