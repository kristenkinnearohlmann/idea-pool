class ProjectController < ApplicationController

    get '/projects' do
        erb :'projects/index'
    end

    post '/projects' do
        # TODO: Finish create code
        # Remove once validation/create are complete
        puts "In projects POST"
        puts params
        redirect '/'
        # Put final code below
        # Add "fix" code to add :in_private to params
    end

    get '/projects/new' do
        if Helpers.is_logged_in?(session)
            erb :'projects/new'
        else
            flash.next[:msg] = "You must be logged in to create a project."
            redirect '/projects'
        end
    end

    get '/projects/:id/edit' do
        if Helpers.is_logged_in?(session)
            @project = Project.find(params[:id])

            if @project.user_id == session[:user_id]
                erb :'projects/edit'
            else
                flash.next[:msg] = "You must be the project owner to edit."
                redirect "/projects/#{params[:id]}"
            end
        else
            flash.next[:msg] = "You must be logged in to edit an project."
            redirect '/login'
        end
    end

    get '/projects/:id' do
        @project = Project.find(params[:id])
        if @project.is_private == false || (@project.is_private == true && Helpers.is_logged_in?(session) && Helpers.current_user(session) == @project.user)
            erb :'projects/show'
        else
            flash.next[:msg] = "You do not have access to that project. Please select a project below."
            redirect '/projects'
        end
    end

    patch '/projects/:id' do
        project = Project.find(params[:id])
        # Add both project and idea is_private
        # # If in_private is not checked, add as false, otherwise update as true
        # if !params[:idea].keys.include?("is_private")
        #     params[:idea][:is_private] = false
        # else
        #     params[:idea][:is_private] = true
        # end

        if Helpers.current_user(session).id == project.user_id
            # TODO: Implement project edit

            flash.next[:msg] = "Project updated"
            redirect "/projects/#{project.id}"
        else
            flash.next[:msg] = "You must be the project owner to edit."
            redirect '/projects'
        end
    end

    delete '/projects/:id' do
        project = Project.find(params[:id])

        if Helpers.is_logged_in?(session) && Helpers.current_user(session).id == project.user_id
            # destroy fires the callback dependent in project model, delete would be just the target table
            project.destroy
            flash.next[:msg] = "Project deleted"
            redirect '/projects'
        else
            flash.next[:msg] = "You must be the owner to delete a project."
            redirect "/projects/#{project.id}"
        end
    end

end