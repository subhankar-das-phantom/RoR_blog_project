# frozen_string_literal: true

ENV['BUNDLE_GEMFILE'] ||= File.expand_path('../Gemfile', __dir__)

require 'bundler/setup' # Set up gems listed in the Gemfile.

# Make bootsnap optional for Docker environments
begin
  require 'bootsnap/setup' unless ENV['RAILS_ENV'] == 'production'
rescue LoadError
  # Bootsnap is not available, continue without it
  puts "Warning: bootsnap not available, continuing without it"
end
