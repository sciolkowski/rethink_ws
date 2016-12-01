FROM ruby:2.3
MAINTAINER szymon.ciolkowski@eengine.pl

RUN useradd -d /home/docker -m -s /bin/bash docker && echo "docker:docker" | chpasswd && adduser docker sudo \
&& chown -R docker:docker /home/docker \
&& mkdir -p /home/docker/rethink_ws \
&& apt-get update && apt-get install -y \
build-essential \
nodejs

WORKDIR /home/docker/rethink_ws

COPY Gemfile ./
RUN gem install bundler && bundle install --jobs 20 --retry 5

USER docker
