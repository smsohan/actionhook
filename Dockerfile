FROM ruby:2.7

WORKDIR /usr/src/app

COPY . .

RUN bundle install

