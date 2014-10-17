class AddMoreColumnsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :name, :string, null: false
    add_column :users, :location, :string
    add_column :users, :image, :string, null: false
    add_column :users, :story, :text
  end
end
