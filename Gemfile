source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

plugin 'bundler-graph'

IS_JRUBY = (defined? JRUBY_VERSION)
if IS_JRUBY
  ruby '3.1.4'
  gem 'activerecord-jdbc-adapter', '>= 70.2'
  gem 'activerecord-jdbcpostgresql-adapter'
else
  ruby "3.4.2"
  gem 'pg', '>= 1.5.7', '< 2.0'
end

# Async gems used in rake task show_unavailable_videos
gem 'async'
gem 'async-http'

# Bundle edge Rails instead: gem "rails", github: "rails/rails", branch: "main"
gem "rails", "~> 8.0.2"

gem 'nokogiri', '>= 1.14.1', '< 2'

# Use Puma as the app server
gem 'puma', '>= 6.4.3' # Dependabot recommendation


# Hotwire's SPA-like page accelerator [https://turbo.hotwired.dev]
gem "turbo-rails"

gem "propshaft"
gem "jsbundling-rails"
gem "dartsass-rails"

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', '>= 1.4.2', require: false

# To deal with the warning below, remove when spring is updated:
# warning: /Users/kbennett/.rvm/rubies/ruby-3.3.4/lib/ruby/3.3.0/mutex_m.rb was loaded from the standard library,
# but will no longer be part of the default gems since Ruby 3.4.0.
# Add mutex_m to your Gemfile or gemspec.
# Also contact author of spring-2.1.1 to add mutex_m into its gemspec.
gem 'mutex_m'

gem "google-protobuf", ">= 4.27.5"  # Dependabot recommendation


group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]

  gem 'pry'
end

group :test do
  gem 'rspec-rails'
  gem 'capybara'
  gem 'capybara-screenshot'
  # gem 'selenium-webdriver', '~> 3.141'
  gem 'shoulda-matchers'
  gem 'launchy'
  gem 'webdrivers', '>= 5.3.1', '< 6'
end

group :development do
  # For the `bundle graph` command:
  gem 'bundler-graph'
  gem 'ruby-graphviz'

  # Access an interactive console on exception pages or by calling 'console' anywhere in the code.
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '~> 3.5'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem "tzinfo-data", platforms: %i[ windows jruby ]

gem 'amazing_print'

# Explicitly specify Rails components with their new minimum versions
gem "actionpack", ">= 8.0.2"
gem "net-imap", ">= 0.5.6"

gem 'sitemap_generator'
