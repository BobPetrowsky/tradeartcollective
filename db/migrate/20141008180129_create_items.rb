class CreateItems < ActiveRecord::Migration
  def change
    create_table :items do |t|
      t.integer :user_id, null: false
      t.integer :price, null: false
      t.string :img, null: false
      t.string :description

      t.timestamps
    end
  end
end
