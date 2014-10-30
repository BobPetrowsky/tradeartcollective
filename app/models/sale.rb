class Sale < ActiveRecord::Base
  belongs_to :user
  has_one :shipping
  belongs_to :item

  validates :user, presence: true
  validates :shipping, presence: true
  validates :checkout_id, presence: true
  validates :create_time, presence: true
  validates :short_description, presence: true
  validates :amount, presence: true
  validates :payer_name, presence: true

  def self.total(sales)
    amount = 0
    sales.each do |sale|
      if sale.refunded == false
        amount += sale.amount
      end
    end
    amount
  end

  def self.sold_to(sales)
    places = []
    sales.each do |sale|
      if sale.refunded == false
        places << sale.shipping.state if !places.include?(sale.shipping.state)
      end
    end
    places.join(",")
  end

  def self.create_from_wepay(response, user, item)
    create! do |sale|
      sale.user = user
      sale.item = item
      sale.checkout_id = response["checkout_id"]
      sale.create_time = response["create_time"]
      sale.short_description = response["short_description"]
      sale.long_description = response["long_description"]
      sale.amount = response["amount"]
      sale.payer_name = response["payer_name"]
      sale.payer_email = response["payer_email"]
      sale.shipping = Shipping.new({
        name: response["shipping_address"]["name"],
        address1: response["shipping_address"]["address1"],
        address2: response["shipping_address"]["address2"],
        city: response["shipping_address"]["city"],
        state: response["shipping_address"]["state"],
        zip: response["shipping_address"]["zip"],
        country: response["shipping_address"]["country"]
      })
    end
  end
end
