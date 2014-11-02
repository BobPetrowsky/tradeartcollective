class Item < ActiveRecord::Base
  belongs_to :user
  has_one :sale
  has_many :images
  accepts_nested_attributes_for :images

  monetize :price

  composed_of :price,
              :class_name => 'Money',
              :mapping => %w(price cents),
              :converter => Proc.new { |value| value.respond_to?(:to_money) ? value.to_money : Money.empty }

  validates :user, presence: true
  validates :name, presence: true
  validates :price, presence: true

  # creates a checkout object using WePay API for this farmer
  def create_checkout(redirect_uri)
    # calculate app_fee as 10% of produce price

    price = self.price.to_s

    app_fee = self.price.to_s * 0.3

    params = {
      :account_id => self.user.wepay_account_id,
      :short_description => "#{self.name} sold by #{self.user.name}",
      :long_description => "#{self.description}",
      :type => :GOODS,
      :amount => price,
      :app_fee => app_fee,
      :fee_payer => :payee,
      :mode => :iframe,
      :redirect_uri => redirect_uri,
      :require_shipping => true,
    }
    response = TradeArtCollective::Application::WEPAY.call('/checkout/create', self.user.wepay_access_token, params)

    if !response
      raise "Error - no response from WePay"
    elsif response['error']
      raise "Error - " + response["error_description"]
    end

    return response
  end
end
