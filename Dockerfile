FROM ruby:2.5.3

RUN apt-get update -yqq \
  && apt-get install -yqq --no-install-recommends \
    postgresql-client \
  && apt-get -q clean \
  && rm -rf /var/lib/apt/lists

# Pre-install gems with native extensions
RUN gem install nokogiri -v "1.6.8.1"

#NODE JS
RUN curl -sL https://deb.nodesource.com/setup_10.x | bash - \
        && apt-get install -y nodejs

WORKDIR /usr/src/app
COPY Gemfile* ./
RUN bundle install
COPY . .
ENV APP_HOME /app

# Pre-compile assets
# ENV RAILS_ENV production
