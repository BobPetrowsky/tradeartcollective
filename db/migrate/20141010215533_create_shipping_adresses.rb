class CreateShippingAdresses < ActiveRecord::Migration
  def change
    create_table :shipping_adresses do |t|
      t.integer :sale_id, null: false
      t.string :name
      t.string :address1
      t.string :address2
      t.string :city
      t.string :state
      t.string :zip
      t.string :country
    end
  end
end
