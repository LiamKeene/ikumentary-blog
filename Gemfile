source 'https://rubygems.org'
ruby '2.0.0'

gem 'rails', '4.0.0'
gem 'bcrypt-ruby', '3.0.1'

group :development, :test do
  # If a more complicated DB required, change to Postgres
  gem 'sqlite3', '1.3.7'
  gem 'rspec-rails', '2.14.0'
  gem 'guard-rspec', '3.0.2'
  gem 'spork-rails', github: 'sporkrb/spork-rails'
  gem 'guard-spork', '1.5.1'
  gem 'childprocess', '0.3.9'
end

group :test do
  gem 'rubyzip', '< 1.0.0'
  gem 'selenium-webdriver', '2.33.0'
  gem 'capybara', '2.1.0'
  gem 'factory_girl_rails', '4.2.1'
end

gem 'sass-rails', '4.0.0'
gem 'uglifier', '2.1.2'
gem 'coffee-rails', '4.0.0'
gem 'jquery-rails', '3.0.4'
gem 'turbolinks', '1.3.0'
gem 'jbuilder', '1.5.0'
gem 'kaminari'
gem 'truncate_html'
gem 'friendly_id', '~> 5.0.0'
gem 'rails-settings-cached', '0.3.1'
gem 'ckeditor'
gem 'paperclip'

group :doc do
  gem 'sdoc', '0.3.20', require: false
end

group :production do
  gem 'pg', '0.16.0'
  gem 'rails_12factor', '0.0.2'
end
