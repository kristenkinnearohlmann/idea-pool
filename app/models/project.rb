class Project < ActiveRecord::Base
    has_many :idea_projects
end