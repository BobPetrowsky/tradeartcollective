class AddColumnToSales < ActiveRecord::Migration
  def change
    add_column :sales, :user_id, :integer, null: false
  end
end
