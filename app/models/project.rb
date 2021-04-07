class Project < ActiveRecord::Base
    belongs_to :user
    has_many :idea_projects
    has_many :ideas, through: :idea_projects
end