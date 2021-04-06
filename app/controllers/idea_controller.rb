class IdeaController < ApplicationController
    
    get '/ideas' do
        erb :'ideas/index'
    end
end