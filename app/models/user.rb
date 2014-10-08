class User < ActiveRecord::Base
  has_one :about

  validates :email, presence: true

  def self.create_with_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.about.name = auth.info.name
      user.about.image = auth.info.image
      user.about.location = auth.info.location
      user.about.save!
    end
  end
end
