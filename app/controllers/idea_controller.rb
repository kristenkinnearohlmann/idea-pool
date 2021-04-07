class IdeaController < ApplicationController
    
    get '/ideas' do
        erb :'ideas/index'
    end

    get '/ideas/new' do
        if Helpers.is_logged_in?(session)
            erb :'ideas/new'
        else
            flash.next[:msg] = "You must be logged in to create an idea."
            redirect '/ideas'
        end
    end
    
    get '/ideas/:id' do
        @idea = Idea.find(params[:id])
        if @idea.is_private == false || (@idea.is_private == true && Helpers.is_logged_in?(session) && Helpers.current_user(session) == @idea.user)
            erb :'ideas/show'
        else
            flash.next[:msg] = "You do not have access to that idea. Please select an idea below."
            redirect '/ideas'
        end
    end

end