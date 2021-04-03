class CreateIdeaProjects < ActiveRecord::Migration[5.2]
  def change
    create_table :idea_projects do |t|
      t.integer :idea_id
      t.integer :project_id
      t.timestamps null: false
    end
  end
end
