class UserController < ApplicationController
    
    get '/signup' do
        if Helpers.is_logged_in?(session)
            # TODO: Flash - You are already logged in
            redirect "users/#{Helpers.current_user(session).id}"
        else
            erb :'users/signup'
        end
    end

    post '/signup' do
        if user = User.find_by(email: params[:email])
            flash.next[:msg] = "User exists. Please log in."
            redirect '/login'
        else
            if params[:email] != "" && params[:password] != "" && params[:full_name] != ""
                user = User.create(params)
                session[:user_id] = user.id
                redirect "users/#{user.id}"
            else
                redirect '/signup'
            end
        end
    end

    get '/login' do
        erb :'users/login'
    end

    post '/login' do
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
        if Helpers.is_logged_in?(session) && Helpers.current_user(session).id == params[:user_id].to_i
            @user = Helpers.current_user(session)
            erb :'users/show'
        else
            redirect '/login'
        end
    end

end