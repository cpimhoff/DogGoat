source 'https://rubygems.org'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.2.5.1'
# Use postgres as the database for Active Record
gem 'pg'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.1.0'

# Preprocess outgoing emails to inline styles and link images
gem 'premailer-rails'
gem 'nokogiri' # dependency for 'premailer-rails'

# Simple, RESTful compatible form semantic sugar
gem 'formtastic', '~> 3.0'
# Markdown parser and render
gem 'redcarpet', '~> 3.3'
# Paginater!
gem 'kaminari'
# Creates routes and generates URL slugs for Models
gem 'friendly_id', '~> 5.1.0'
# Admin Portal for CRUDing database
gem 'rails_admin'
# Makes ActiveRecord .where calls into Ruby blocks
gem 'squeel'

# Helps manage ENV variables (in LOCAL builds only!)
gem 'figaro'

# Use jquery as the JavaScript library
gem 'jquery-rails'
# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.0'
# bundle exec rake doc:rails generates the API under doc/api.
gem 'sdoc', '~> 0.4.0', group: :doc

# Use ActiveModel has_secure_password
gem 'bcrypt', '~> 3.1.7'

# Use Unicorn as the app server
# gem 'unicorn'

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug'
end

group :development do
  # Access an IRB console on exception pages or by using <%= console %> in views
  gem 'web-console', '~> 2.0'

  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
end

# Used by Heroku for static assets and logging
gem 'rails_12factor', group: :production
# Specify Ruby Version
ruby "2.0.0"
