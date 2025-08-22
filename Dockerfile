FROM ruby:3.2

# Install dependencies (Node.js for Rails + Postgres client if needed)
RUN apt-get update -qq && apt-get install -y nodejs postgresql-client

# Set working directory
WORKDIR /app

# Set production environment
ENV RAILS_ENV=production
ENV BOOTSNAP_DISABLE=1

# Install Ruby gems
COPY Gemfile Gemfile.lock ./
RUN bundle install --without development test


# Copy rest of the app
COPY . .

# Precompile assets (if you use sprockets/webpacker)
RUN bundle exec rake assets:precompile || echo "No assets to compile"

# Expose the default Rails port
EXPOSE 3000

# Run the Rails server
CMD ["bundle", "exec", "rails", "server", "-b", "0.0.0.0"]
