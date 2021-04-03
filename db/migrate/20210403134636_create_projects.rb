class CreateProjects < ActiveRecord::Migration[5.2]
  def change
    create_table :projects do |t|
      t.string :name
      t.string :description
      t.string :main_language
      t.string :github_repo
      t.boolean :is_private, :default => false
      t.integer :user_id
      t.timestamps null: false
    end
  end
end
