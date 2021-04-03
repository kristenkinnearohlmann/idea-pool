# get environment configuration
require_relative './config/environment'

# allows use of PATCH and DELETE routes
Rack::MethodOverride

run ApplicationController