class CreateAbouts < ActiveRecord::Migration
  def change
    create_table :abouts do |t|
      t.integer :user_id, null: false
      t.string :name, null: false
      t.string :location
      t.string :image, null: false
      t.text :story
    end
  end
end
