source 'http://rubygems.org'

gem 'sinatra'
gem 'activerecord', :require =>'active_record'
gem 'sinatra-activerecord', :require => 'sinatra/activerecord'
gem 'rake'
gem 'thin'
gem 'bcrypt'
gem 'require_all'
gem 'sinatra-flash'

group :development do
  gem 'shotgun'
  gem 'pry'
  gem 'tux'
  gem 'sqlite3'
end

group :test do
  gem 'rspec'
  gem 'capybara'
  gem 'rack-test'
  gem 'database_cleaner'
end

group :production do
  gem 'pg'
  gem 'activerecord-postgresql-adapter'
end
