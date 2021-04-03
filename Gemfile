# frozen_string_literal: true

source "https://rubygems.org"

git_source(:github) {|repo_name| "https://github.com/#{repo_name}" }

# gem "rails"

# the first three gems are needed for Sinatra and ActiveRecord;
# using ActiveRecord >= 5.23 and < 5.3, aliasing the second
# 2 items per Flatiron lessons/labs
gem 'sinatra'
gem 'activerecord', '~> 5.2.3', :require => 'active_record'
gem 'sinatra-activerecord', :require => 'sinatra/activerecord'
# allows you to create tasks, useful for a console task to
# run in pry as needed
gem 'rake'
# allows you to require full folders of files easily
gem 'require_all'
# database
gem 'sqlite3', '~> 1.3.6'
# used to work with salted, hashed passwords for security
# needed to go to rubygems.org to find proper syntax
# to run with WSL
gem 'bcrypt', '~> 3.1', '>= 3.1.12'
# used for local server
gem 'thin'
# used to serve site, Linux only, run from WSL terminal
gem 'shotgun'
# thank God for pry, what's going on inside my code?
gem 'pry'
# tool to try out your models
gem 'tux'