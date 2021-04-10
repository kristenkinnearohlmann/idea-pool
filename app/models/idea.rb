class Idea < ActiveRecord::Base
    belongs_to :user
    has_many :idea_projects, dependent: :destroy # this properly ties the table to IdeaProject for cascading deletes
    has_many :projects, through: :idea_projects

    validates :name, :description, presence: true
    validates :name, length: { minimum: 3 }
    validates :description, length: { minimum: 4 }
end