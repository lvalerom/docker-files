FROM centos:8
RUN yum install -y wget unzip
RUN wget -O /tmp/jre-8u211-linux-x64.rpm https://javadl.oracle.com/webapps/download/AutoDL?BundleId=238718_478a62b7d4e34b78b671c754eaaf38ab
RUN rpm -ivh --prefix=/usr/java /tmp/jre-8u211-linux-x64.rpm
RUN echo "export JAVA_HOME=/usr/java/jre1.8.0_211-amd64" >> ~/.profile
RUN echo "export PATH=$PATH:$JAVA_HOME/bin" >> ~/.profile
RUN echo "export GEOSERVER_HOME=/usr/share/geoserver" >> ~/.profile
ENV JAVA_HOME=/usr/java/jre1.8.0_211-amd64
ENV PATH=$PATH:$JAVA_HOME/bin
ENV GEOSERVER_HOME=/usr/share/geoserver
RUN wget -O /tmp/geoserver-2.17.1.zip https://sourceforge.net/projects/geoserver/files/GeoServer/2.17.1/geoserver-2.17.1-bin.zip/download
RUN unzip /tmp/geoserver-2.17.1.zip -d /usr/share/geoserver

EXPOSE 8080
CMD [ "/usr/share/geoserver/bin/startup.sh" ]