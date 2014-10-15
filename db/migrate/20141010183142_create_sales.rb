class CreateSales < ActiveRecord::Migration
  def change
    create_table :sales do |t|
      t.integer :checkout_id, null: false
      t.integer :create_time, null: false
      t.string :short_description, null: false
      t.string :long_description
      t.decimal :amount, null: false
      t.string :payer_name, null: false
      t.integer :shipping_address_id
      t.boolean :shipped, default: false
      t.boolean :refunded, default: false
    end
  end
end
