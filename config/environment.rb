# load gems when your application runs
require 'bundler'
Bundler.require

# set up database connection
ActiveRecord::Base.establish_connection(
    :adapter => "sqlite3",
    :database => "./db/appdb.sqlite"
)

# require all files in the app folder, where the controllers,
# models, and views will be stored
require_all 'app'