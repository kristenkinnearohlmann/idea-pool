class IdeaProject < ActiveRecord::Base
    belongs_to :idea
    belongs_to :project
end