FROM ubuntu:14.04
MAINTAINER Aurynn Shaw <self@aurynn.com>

RUN apt-get -y update && apt-get install -y python python-pip
RUN pip install bottle
ADD . /app

CMD /usr/bin/python /app/app.py
