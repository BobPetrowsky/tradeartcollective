class CreateItemImages < ActiveRecord::Migration
  def change
    create_table :item_images do |t|
      t.integer :item_id, null: false
      t.string :image, null: false
    end
  end
end
