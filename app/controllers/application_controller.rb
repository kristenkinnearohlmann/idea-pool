class ApplicationController < Sinatra::Base
    # extends Sinatra with methods and Rake tasks for dealing
    # with SQL databses using ActiveRecord
    register Sinatra::ActiveRecordExtension
    
    # set up sessions
    # TODO: how to hide secret in the future
    configure do
        set :public_folder, 'public'
        enable :sessions
        set :session_secret, "vJHqHCgewkv7N9NE"
    end

    # set an alias for views so view files can be stored in 
    # directories related to their model name
    set :views, Proc.new { File.join(root, "../views/") }

    get '/' do
        erb :index
    end
end