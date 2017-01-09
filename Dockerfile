FROM ruby:2.2.2
MAINTAINER "Noah Davis"

ENV LANG C.UTF-8

WORKDIR /usr/src/app
COPY Gemfile /usr/src/app/
COPY Gemfile.lock /usr/src/app/

RUN apt-get update && apt-get install -y git-all
RUN bundle install -j 4

RUN adduser app -u 9000
COPY . /usr/src/app
RUN chown -R app:app /usr/src/app

USER app
RUN cd /usr/src/app/config && git clone https://github.com/shutterstock/List-of-Dirty-Naughty-Obscene-and-Otherwise-Bad-Words.git profanities && cd profanities && git reset --hard 88a23c1a32fd7d2350d235a3c4c884faf3807fb0
RUN cd /usr/src/app

CMD ["/usr/src/app/bin/decorum"]
