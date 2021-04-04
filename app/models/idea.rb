class Idea < ActiveRecord::Base
    belongs_to :user
    has_many :idea_projects
    has_many :projects, through: :idea_projects
end