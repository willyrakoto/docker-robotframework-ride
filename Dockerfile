FROM ubuntu:latest

MAINTAINER softsam

#ENV http_proxy=http://p-goodway.rd.francetelecom.fr:3128
#ENV https_proxy=http://p-goodway.rd.francetelecom.fr:3128

RUN echo "deb http://archive.ubuntu.com/ubuntu wily main universe" | tee /etc/apt/sources.list.d/wily-copies.list

RUN apt-get -y update \
    && apt-get install -y python-wxgtk2.8 \
    && apt-get install -y python python-pip \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN rm /etc/apt/sources.list.d/wily-copies.list

RUN pip install robotframework==3.0 requests==2.12.3 robotframework-requests==0.4.5 robotframework-ride==1.5.2.1

RUN mkdir /robot
VOLUME /robot
COPY runpybot.sh /tmp/
RUN chmod +x /tmp/runpybot.sh
WORKDIR /robot

CMD ["/tmp/runpybot.sh"]
