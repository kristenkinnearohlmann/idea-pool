class IdeaController < ApplicationController
    
    get '/ideas' do
        erb :'ideas/index'
    end

    post '/ideas' do
        if !Helpers.is_logged_in?(session)
            flash.next[:msg] = "You must be logged in to perform this action."
            redirect '/login'
        else
            user = User.find(session[:user_id])

            # If is_private is not checked, add as false, otherwise update as true
            if !params[:idea].keys.include?("is_private")
                params[:idea][:is_private] = false
            else
                params[:idea][:is_private] = true
            end

            idea = Idea.new(params[:idea])
            if idea.valid?
                user.ideas << idea
                redirect "/ideas/#{idea.id}"
            else
                flash.next[:msg] = Helpers.build_error_msg(idea.errors).join(", ")
                redirect '/ideas/new'
            end
        end
    end

    get '/ideas/new' do
        if Helpers.is_logged_in?(session)
            erb :'ideas/new'
        else
            flash.next[:msg] = "You must be logged in to create an idea."
            redirect '/ideas'
        end
    end
    
    get '/ideas/:id/edit' do
        if Helpers.is_logged_in?(session)
            @idea = Idea.find(params[:id])

            if @idea.user_id == session[:user_id]
                erb :'ideas/edit'
            else
                flash.next[:msg] = "You must be the idea owner to edit."
                redirect "/ideas/#{params[:id]}"
            end
        else
            flash.next[:msg] = "You must be logged in to edit an idea."
            redirect '/login'
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

    patch '/ideas/:id' do
        idea = Idea.find(params[:id])
        # If is_private is not checked, add as false, otherwise update as true
        if !params[:idea].keys.include?("is_private")
            params[:idea][:is_private] = false
        else
            params[:idea][:is_private] = true
        end

        if Helpers.current_user(session).id == idea.user_id
            idea.name = params[:idea][:name]
            idea.description = params[:idea][:description]
            idea.is_private = params[:idea][:is_private]
            idea.save

            flash.next[:msg] = "Idea updated"
            redirect "/ideas/#{idea.id}"
        else
            flash.next[:msg] = "You must be the idea owner to edit."
            redirect '/ideas'
        end
    end

    delete '/ideas/:id' do
        idea = Idea.find(params[:id])
        if Helpers.is_logged_in?(session) && Helpers.current_user(session).id == idea.user_id
            if idea.projects.count != 0
                flash.next[:msg] = "This idea is attached to one or more projects and cannot be deleted."
                redirect "/ideas/#{idea.id}"
            else
                idea.destroy
                flash.next[:msg] = "Idea deleted"
                redirect '/ideas'
            end
        else
            flash.next[:msg] = "You must be the owner to delete an idea."
            redirect "/ideas/#{idea.id}"
        end
    end

end