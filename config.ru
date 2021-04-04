# get environment configuration
# per Flatiron issue I Googled, 
# config.ru does not support require_relative,
# so I changed to require
require './config/environment'

# allows use of PATCH and DELETE routes
Rack::MethodOverride

use UserController

run ApplicationController