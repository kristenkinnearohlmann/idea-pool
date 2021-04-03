class CreateIdeas < ActiveRecord::Migration[5.2]
  def change
    create_table :ideas do |t|
      t.string :name
      t.text :description
      t.boolean :is_private, :default => false
      t.integer :user_id
      t.timestamps null: false
    end
  end
end
