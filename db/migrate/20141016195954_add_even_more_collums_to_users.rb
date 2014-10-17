class AddEvenMoreCollumsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :background, :string
    add_column :users, :border, :string
  end
end
