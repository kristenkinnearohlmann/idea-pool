class CreateProjects < ActiveRecord::Migration[5.2]
  def change
    create_table :projects do |t|
      t.string :name
      t.string :description
      t.boolean :is_private, :default => false
      t.timestamps null: false
    end
  end
end