class UserController < ApplicationController
    
    get '/signup' do
        erb :'users/signup'
    end

    post '/signup' do
        puts params[:email]
    end
end