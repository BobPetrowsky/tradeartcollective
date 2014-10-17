require 'file_size_validator'
class User < ActiveRecord::Base
  has_many :items
  has_many :sales

  validates :email, presence: true
  validates :name, presence: true
  validates :image, presence: true
  validates_size_of :video, maximum: 35.megabytes, message: "should be less than 35MB"

  mount_uploader :video, ItemUploader
  mount_uploader :background, ItemUploader

  def has_items_for_sale?
    items.each do |item|
      if item.sold == false
        return true
      else
        false
      end
    end
  end

  def self.create_with_omniauth(auth)
    User.find_or_create_by!(email: auth.info.email) do |user|
      user.email = auth.info.email
      user.name = auth.info.name
      user.image = auth.info.image
      user.location = auth.info.location
    end
  end

  def wepay_authorization_url(redirect_uri)
    TradeArtCollective::Application::WEPAY.oauth2_authorize_url(redirect_uri, self.email, self.name)
  end

  # takes a code returned by wepay oauth2 authorization and makes an api call to generate oauth2 token for this user.
  def request_wepay_access_token(code, redirect_uri)
    response = TradeArtCollective::Application::WEPAY.oauth2_token(code, redirect_uri)
    if response['error']
      raise "Error - "+ response['error_description']
    elsif !response['access_token']
      raise "Error requesting access from WePay"
    else
      self.wepay_access_token = response['access_token']
      self.save
    end
  end

  def has_wepay_access_token?
    !self.wepay_access_token.nil?
  end

  # makes an api call to WePay to check if current access token for user is still valid
  def has_valid_wepay_access_token?
    if self.wepay_access_token.nil?
      return false
    end
    response = TradeArtCollective::Application::WEPAY.call("/user", self.wepay_access_token)
    response && response["user_id"] ? true : false
  end

  # takes a code returned by wepay oauth2 authorization and makes an api call to generate oauth2 token for this user.
  def request_wepay_access_token(code, redirect_uri)
    response = TradeArtCollective::Application::WEPAY.oauth2_token(code, redirect_uri)
    if response['error']
      raise "Error - "+ response['error_description']
    elsif !response['access_token']
      raise "Error requesting access from WePay"
    else
      self.wepay_access_token = response['access_token']
      self.save

    #create WePay account
      self.create_wepay_account
    end
  end


  def has_wepay_account?
    self.wepay_account_id != 0 && !self.wepay_account_id.nil?
  end

  # creates a WePay account for this user with the farm's name
  def create_wepay_account
    if self.has_wepay_access_token? && !self.has_wepay_account?
      params = { :name => self.name, :description => "Member of the Trade Art Collective"}
      response = TradeArtCollective::Application::WEPAY.call("/account/create", self.wepay_access_token, params)

      if response["account_id"]
        self.wepay_account_id = response["account_id"]
        return self.save
      else
        raise "Error - " + response["error_description"]
      end

    end
    raise "Error - cannot create WePay account"
  end
end

