class ProjectController < ApplicationController

    get '/projects' do
        erb :'projects/index'
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