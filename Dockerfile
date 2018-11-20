FROM ruby:2.5.3
RUN curl -sL https://deb.nodesource.com/setup_10.x | bash -
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs
RUN mkdir /crimson2
WORKDIR /crimson2
COPY Gemfile /crimson2/Gemfile
COPY Gemfile.lock /crimson2/Gemfile.lock
RUN bundle install
COPY . /crimson2