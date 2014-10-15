class Shipping < ActiveRecord::Base
  belongs_to :sale

  validates :sale, presence: true
end
