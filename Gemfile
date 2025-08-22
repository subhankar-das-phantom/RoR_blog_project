source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "~> 3.2.0"


# Bundle edge Rails instead: gem "rails", github: "rails/rails", branch: "main"
gem "rails", "~> 7.0.0"
gem 'concurrent-ruby', '< 1.3.5'

# The original asset pipeline for Rails
gem "sprockets-rails", ">= 3.4.0"

# Use postgresql as the database for Active Record
gem "pg", "~> 1.6"

# Use the Puma web server
gem "puma", "~> 5.0"

# Use JavaScript with ESM import maps
gem "importmap-rails"

# Hotwire's SPA-like page accelerator
gem "turbo-rails"

# Hotwire's modest JavaScript framework
gem "stimulus-rails"

# Use Tailwind CSS
gem "tailwindcss-rails"

# Build JSON APIs with ease
gem "jbuilder"

# Use Redis adapter to run Action Cable in production
gem "redis", "~> 4.0"


# Use Kredis to get higher-level data types in Redis
# gem "kredis"

# Use Active Model has_secure_password
# gem "bcrypt", "~> 3.1.7"

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem "tzinfo-data", platforms: %i[ windows jruby ]


# Use Sass to process CSS
# gem "sassc-rails"

# Use image_processing for Active Storage variants
# gem "image_processing", "~> 1.2"

# Authentication
gem "devise"

# Friendly URLs
gem "friendly_id"

# Background jobs
gem "sidekiq"

# Search
gem "pg_search"

# Pagination
gem "kaminari"

# API token authentication
gem "jwt"

group :development, :test do
  gem "debug", platforms: %i[mri mingw x64_mingw]
  gem "rspec-rails"
  gem "factory_bot_rails"
end

group :development do
  # Use console on exceptions pages
  gem "web-console"

  # Reduces boot times through caching; required in config/boot.rb
  gem "bootsnap", require: false

  # Add speed badges
  # gem "rack-mini-profiler"

  # Speed up commands on slow machines / big apps
  # gem "spring"
end
