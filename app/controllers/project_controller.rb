class ProjectController < ApplicationController

    get '/projects' do
        erb :'projects/index'
    end

    post '/projects' do

        if !Helpers.is_logged_in?(session)
            flash.next[:msg] = "You must be logged in to perform this action."
            redirect '/login'
        else
            user = User.find(session[:user_id])

            # If in_private is not checked, add as false, otherwise update as true
            if !params[:project].keys.include?("is_private")
                params[:project][:is_private] = false
            else
                params[:project][:is_private] = true
            end

            # If new idea, handle in_private boolean and remove "id" key to process params hash
            # for new idea. Also, remove stray keys if an existing idea is picked but the new idea
            # is also filled in
            if params[:idea][:id] == "-1" 
                # new idea
                if !params[:idea].keys.include?("is_private")
                    params[:idea][:is_private] = false
                else
                    params[:idea][:is_private] = true
                end
                params[:idea].delete("id")
            else
                # existing idea
                params[:idea].delete("name") if params[:idea].keys.include?("name")
                params[:idea].delete("description") if params[:idea].keys.include?("description")
                params[:idea].delete("is_private") if params[:idea].keys.include?("is_private")
            end

            project = Project.new(params[:project])
            idea = Idea.new(params[:idea]) if !params[:idea].keys.include?("id")

            if !project.valid? || !idea.valid?
                err_msgs = Helpers.build_error_msg(project.errors, "Project") | Helpers.build_error_msg(idea.errors, "Idea")
                flash.next[:msg] = err_msgs.join(", ")
                redirect '/projects/new'
            end
            binding.pry
            idea = Idea.find(params[:idea][:id]) if params[:idea].keys.include?("id")
            binding.pry
            # # create project and validate
            # project = Project.new(params[:project])
            # # TODO: Add validation
        
            # # create idea and validate
            # if !params[:idea].keys.include?("id") 
            #     idea = Idea.new(params[:idea])
            #     binding.pry
            #     # TODO: Add validation
            #     binding.pry
            # else
            #     # existing idea, retrieve
            #     idea = Idea.find(params[:idea][:id])
            # end

            # idea.save
            # user.ideas << idea

            # project.save
            # user.projects << project

            # # add project to idea
            # idea.projects << project

            # redirect "/projects/#{project.id}"
        end
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