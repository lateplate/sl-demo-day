source 'https://rubygems.org'

gem 'rails', '3.2.12'
gem 'figaro'

# Bundle edge Rails instead:
# gem 'rails', :git => 'git://github.com/rails/rails.git'

gem 'omniauth-facebook', '1.4.0'
gem 'koala'
gem 'xmpp4r_facebook'

# For Heroku to work, these need to stay outside the group: assets block. Log threw failures and
# looked up on StackOverlow. This fixed it. -- Dan
gem 'sass-rails',   '~> 3.2.3'
gem 'haml-rails'
gem 'bourbon', '~> 3.1.1'

# Gems used only for assets and not required
# in production environments by default.
group :assets do

  gem 'coffee-rails', '~> 3.2.1'

  # See https://github.com/sstephenson/execjs#readme for more supported runtimes
  # gem 'therubyracer', :platforms => :ruby

  gem 'uglifier', '>= 1.0.3'
end

gem 'jquery-rails'

# Heroku requires Postgres
group :production do
  gem "pg"
end

group :development, :test do
  gem 'sqlite3'
end

# To use ActiveModel has_secure_password
# gem 'bcrypt-ruby', '~> 3.0.0'

# To use Jbuilder templates for JSON
# gem 'jbuilder'

# Use unicorn as the app server
# gem 'unicorn'

# Deploy with Capistrano
# gem 'capistrano'

# To use debugger
# gem 'debugger'
