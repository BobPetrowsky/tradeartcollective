class AddColumnToItems < ActiveRecord::Migration
  def change
    add_column :items, :name, :string, null: false
  end
end
