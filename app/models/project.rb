class Project < ActiveRecord::Base
    belongs_to :user
    has_many :idea_projects, dependent: :destroy # this properly ties the table to IdeaProject for cascading deletes
    has_many :ideas, through: :idea_projects
end