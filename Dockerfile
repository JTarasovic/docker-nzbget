FROM linuxserver/baseimage
MAINTAINER Stian Larsen <lonixx@gmail.com>

ENV APTLIST="wget python"

RUN apt-get update && \
apt-get install $APTLIST -qy && \
curl -o /tmp/rar.tar.gz http://www.rarlab.com/rar/rarlinux-x64-5.3.b5.tar.gz && \
tar xvf /tmp/rar.tar.gz  -C /tmp && \
cp -v /tmp/rar/*rar /usr/bin/ && \
apt-get clean && rm -rf /var/lib/apt/lists/* /var/tmp/*

#Adding Custom files
ADD init/ /etc/my_init.d/
ADD services/ /etc/service/
RUN chmod -v +x /etc/service/*/run /etc/my_init.d/*.sh

#Mappings
VOLUME /config /downloads /logs
EXPOSE 6789
