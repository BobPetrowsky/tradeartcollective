class RenameShippingAdressesToShippings < ActiveRecord::Migration
  def change
    rename_table :shipping_adresses, :shippings
  end
end
