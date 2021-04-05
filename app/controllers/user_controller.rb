class UserController < ApplicationController
    
    get '/signup' do
        erb :'users/signup'
    end

    post '/signup' do
        binding.pry
        # puts params[:email]
        if Helpers.is_logged_in?(session)
            puts "Logged in"
            # Flash already logged in
            # Redirect user show
        elsif user = User.find_by(email: params[:email])
            redirect '/login'
        else
            puts "Make a user"
            # Validate email, password, name filled in
            # Create user
            # Set user_id in session
            # Redirect user show
        end
    end

    get '/login' do
        erb :'users/login'
    end

    post '/login' do
        binding.pry
        # check email
        # check password
        # if valid
        # if invalid
    end

end