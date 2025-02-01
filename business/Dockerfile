ARG RUBY_VERSION=3.0.2
FROM ruby:$RUBY_VERSION-bullseye

# Install dependencies
RUN apt-get clean all && \
    apt-get update -qq && \
    apt-get install -y \
    nodejs \
    npm \
    yarn \
    postgresql-client \
    postgresql-server-dev-all \
    libssl-dev \
    libreadline-dev \
    zlib1g-dev \
    curl \
    git \
    libpq-dev \
    libvips \
    pkg-config \
    build-essential \
    gnupg2 \
    apt-utils \
    libcurl3-dev \
    cmake \
    openssl \
    file \
    nano

# Set the working directory
RUN mkdir /app
WORKDIR /app

# Copy the Gemfile and Gemfile.lock
COPY Gemfile /app/Gemfile
COPY Gemfile.lock /app/Gemfile.lock

# Install packages needed to build gems
RUN gem install bundler && bundle install

# Copy application code
COPY . /app

# Precompile assets (optional, if using Rails with assets)
# RUN bundle exec rake assets:precompile

# Entrypoint prepares the database.
ENTRYPOINT ["/app/bin/docker-entrypoint"]

# Start the server by default, this can be overwritten at runtime
ARG DEFAULT_PORT 3000
EXPOSE ${DEFAULT_PORT}

# Command to run the server
# CMD ['/bin/sh', '-c', 'psql -U postgres -c "CREATE ROLE $${DB_USER} LOGIN PASSWORD $${DB_PASS};"']
CMD ["rails", "server", "-b", "0.0.0.0"]
