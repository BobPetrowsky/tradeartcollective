class AddCollumnItemIdToSales < ActiveRecord::Migration
  def change
    add_column :sales, :item_id, :integer, null: false
  end
end
