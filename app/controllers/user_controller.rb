class UserController < ApplicationController
    
    get '/signup' do
        erb :'users/signup'
    end

    get '/hello' do
        binding.pry
    end

    post '/signup' do
        binding.pry
    end
end