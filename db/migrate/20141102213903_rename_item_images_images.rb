class RenameItemImagesImages < ActiveRecord::Migration
  def change
    rename_table :item_images, :images
  end
end
