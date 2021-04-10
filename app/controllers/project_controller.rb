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

            # If is_private is not checked, add as false, otherwise update as true
            if !params[:project].keys.include?("is_private")
                params[:project][:is_private] = false
            else
                params[:project][:is_private] = true
            end

            # If new idea, handle is_private boolean and remove "id" key to process params hash
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

            # instantiate project and idea
            project = Project.new(params[:project])
            idea = Idea.new(params[:idea]) if !params[:idea].keys.include?("id")

            # TODO: Add project validation
            # test if valid, redirect to creation with errors if not
            if !project.valid? || (idea != nil && !idea.valid?)
                err_msgs = Helpers.build_error_msg(project.errors, "Project") | Helpers.build_error_msg(idea.errors, "Idea")
                flash.next[:msg] = err_msgs.join(", ")
                redirect '/projects/new'
            end

            # valid project, save
            project.save
            user.projects << project

            #  valid idea, save or find by id
            if idea != nil
                idea.save
                user.ideas << idea
            else
                idea = Idea.find(params[:idea][:id]) if params[:idea].keys.include?("id")
            end

            # #add project to idea
            idea.projects << project

            redirect "/projects/#{project.id}"
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

        if Helpers.is_logged_in?(session) && Helpers.current_user(session).id == project.user_id
            user = User.find(session[:user_id])
            
            # If is_private is not checked, add as false, otherwise update as true
            if !params[:project].keys.include?("is_private")
                params[:project][:is_private] = false
            else
                params[:project][:is_private] = true
            end

            # If new idea, handle is_private boolean and remove "id" key to process params hash
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

            # instantiate idea if new
            idea = Idea.new(params[:idea]) if !params[:idea].keys.include?("id")

            # test if valid, redirect to edit with errors if not
            if !project.valid? || (idea != nil && !idea.valid?)
                err_msgs = Helpers.build_error_msg(project.errors, "Project") | Helpers.build_error_msg(idea.errors, "Idea")
                flash.next[:msg] = err_msgs.join(", ")
                redirect '/projects/<%= project.id %>/edit'
            end

            #  valid idea, save or find by id
            if idea != nil
                idea.save
                user.ideas << idea
            else
                idea = Idea.find(params[:idea][:id]) if params[:idea].keys.include?("id")
            end

            # valid project, update and save
            # clear the idea from the project and idea project relationship
            project.ideas.clear

            # update fields + add idea
            project.name = params[:project][:name]
            project.description = params[:project][:description]
            project.main_language = params[:project][:main_language]
            project.github_repo = params[:project][:github_repo]
            project.is_private = params[:project][:is_private]
            # field1,etc
            # idea.projects << project
            # project.save

            # work area

            binding.pry
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