class UserController < ApplicationController
    
    get '/signup' do
        if Helpers.is_logged_in?(session)
            flash.next[:msg] = "You are already logged in."
            redirect "users/#{Helpers.current_user(session).id}"
        else
            erb :'users/signup'
        end
    end

    post '/signup' do
        if user = User.find_by(email: params[:email])
            flash.next[:msg] = "User exists."
            redirect '/login'
        else
            if params[:email] != "" && params[:password] != "" && params[:full_name] != ""
                user = User.new(params)
                if user.valid?
                    user.save
                    session[:user_id] = user.id
                    redirect "users/#{user.id}"
                else
                    flash.next[:msg] = Helpers.build_error_msg(user.errors).join(", ")
                    redirect '/signup'
                end
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
            flash.next[:msg] = "Invalid email or password."
            redirect '/login'
        end
    end

    get '/logout' do
        session.clear
        flash.next[:msg] = "You are now logged out."
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