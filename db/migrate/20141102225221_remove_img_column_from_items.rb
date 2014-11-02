class RemoveImgColumnFromItems < ActiveRecord::Migration
  def change
    remove_column :items, :img
  end
end
