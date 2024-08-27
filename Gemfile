source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

plugin 'bundler-graph'

IS_JRUBY = (RUBY_PLATFORM == 'java')
if IS_JRUBY
  ruby '2.5.7'
  gem 'activerecord-jdbc-adapter', '>= 60.2'
  gem 'activerecord-jdbcpostgresql-adapter'
else
  ruby "3.3.4"
  gem 'pg', '>= 1.4.5', '< 2.0'
end

# Bundle edge Rails instead: gem "rails", github: "rails/rails", branch: "main"
gem "rails", "~> 7.2.0"

gem 'nokogiri', '>= 1.14.1', '< 2'

# Suggested by dependabot alert at https://github.com/keithrbennett/tepper-bennett/security/dependabot/116.
# gem "activerecord", ">= 6.1.7.1"

# Use Puma as the app server
gem 'puma', '>= 6.3.1', '< 7'

# Hotwire's SPA-like page accelerator [https://turbo.hotwired.dev]
gem "turbo-rails"

gem "propshaft"
gem "jsbundling-rails"
gem "dartsass-rails"

# Psych 4 no longer supports aliases, and webpacker uses that feature.
# Keep checking over time to see if we can remove this constraint.
gem 'psych', '< 4'

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', '>= 1.4.2', require: false

# To deal with the warning below, remove when spring is updated:
# warning: /Users/kbennett/.rvm/rubies/ruby-3.3.4/lib/ruby/3.3.0/mutex_m.rb was loaded from the standard library,
# but will no longer be part of the default gems since Ruby 3.4.0.
# Add mutex_m to your Gemfile or gemspec.
# Also contact author of spring-2.1.1 to add mutex_m into its gemspec.
gem 'mutex_m'

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
  gem 'webdrivers'
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
