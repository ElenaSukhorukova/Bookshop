ARG RUBY_VERSION=3.0.2
FROM ruby:3.0.2-bullseye

ARG DOCKER_USER=dockeruser
ARG DOCKER_GROUP=dockergroup

# Create a custom user with UID 1234 and GID 1234
RUN groupadd -g 1234 $DOCKER_GROUP && \
    useradd -m -u 1234 -g $DOCKER_GROUP $DOCKER_USER && \
    usermod -aG sudo $DOCKER_USER

# switch to the user
USER $DOCKER_USER

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


# Add permissions for the user
RUN mkdir /app
#&& chown -R dockeruser:dockergroup /app

# Set the working directory
WORKDIR /app

# Copy the Gemfile and Gemfile.lock
COPY Gemfile /app/Gemfile
COPY Gemfile.lock /app/Gemfile.lock

# Install packages needed to build gems
RUN gem install bundler && bundle install

# Copy application code
COPY . /app

# Precompile assets (optional, if using Rails with assets)
RUN bundle exec rake assets:precompile

# Entrypoint prepares the database.
ENTRYPOINT ["/app/bin/docker-entrypoint"]

# Start the server by default, this can be overwritten at runtime
ARG DEFAULT_PORT 3000
EXPOSE ${DEFAULT_PORT}

# Command to run the server
CMD ["rails", "server", "-b", "0.0.0.0"]
