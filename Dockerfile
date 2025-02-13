FROM ubuntu
MAINTAINER Kimbro Staken
USER root
RUN apt-get update -y
RUN apt-get install -y software-properties-common python-is-python3
RUN add-apt-repository ppa:chris-lea/node.js
RUN echo "deb http://us.archive.ubuntu.com/ubuntu/ precise universe" >> /etc/apt/sources.list
#RUN apt-get update
RUN apt-get install -y nodejs
#RUN apt-get install -y nodejs=0.6.12~dfsg1-1ubuntu1
RUN mkdir /var/www

COPY app.js /var/www/app.js

CMD ["/usr/bin/node", "/var/www/app.js"]
