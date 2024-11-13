ARG RUBY_VERSION=3.0.2
FROM ruby:3.0.2-bullseye

# Install dependencies
RUN apt-get update -qq && \
    apt-get install -y \
    nodejs \
    postgresql-client \
    libssl-dev \
    libreadline-dev \
    zlib1g-dev \
    curl \
    git \
    libpq-dev \
    libvips \
    pkg-config \
    build-essential

# Set the working directory
WORKDIR /myapp

# Copy the Gemfile and Gemfile.lock
COPY Gemfile /myapp/Gemfile
COPY Gemfile.lock /myapp/Gemfile.lock

# Install packages needed to build gems
RUN gem install bundler && bundle install

# Copy application code
COPY . /myapp

# Precompile assets (optional, if using Rails with assets)
RUN bundle exec rake assets:precompile

# Entrypoint prepares the database.
ENTRYPOINT ["/myapp/bin/docker-entrypoint"]

# Start the server by default, this can be overwritten at runtime
ARG DEFAULT_PORT 3000
EXPOSE ${DEFAULT_PORT}

# Command to run the server
CMD ["rails", "server", "-b", "0.0.0.0"]
