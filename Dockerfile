FROM ruby:2.6.3

WORKDIR /home

COPY Gemfile Gemfile
COPY Gemfile.lock Gemfile.lock

RUN gem install bundler && bundle install
