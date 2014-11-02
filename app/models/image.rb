class Image < ActiveRecord::Base
  belongs_to :item

  mount_uploader :image, ItemUploader

  validates :item, presence: true
  validates :image, presence: true

end
