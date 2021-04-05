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
        binding.pry
        erb :'users/login'
    end

    post '/login' do
        binding.pry
        user = User.find_by(email: params[:email])

        if user && user.authenticate(params[:password])
            session[:user_id] = user.id
            redirect "users/#{user.id}"
        else
            # TODO: Flash msg - Invalid email or password
            redirect '/login'
        end
    end

    get '/logout' do
        session.clear
        redirect "/"
    end

    get '/users/:user_id' do
        binding.pry
        if Helpers.is_logged_in?(session) && Helpers.current_user(session).id == params[:user_id].to_i
            erb :'users/show'
        else
            redirect '/login'
        end
    end

end