class ProjectController < ApplicationController

    get '/projects' do
        erb :'projects/index'
    end

    post '/projects' do
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

    get '/projects/:id' do
        @project = Project.find(params[:id])
        if @project.is_private == false || (@project.is_private == true && Helpers.is_logged_in?(session) && Helpers.current_user(session) == @project.user)
            erb :'projects/show'
        else
            flash.next[:msg] = "You do not have access to that project. Please select a project below."
            redirect '/projects'
        end
    end

end