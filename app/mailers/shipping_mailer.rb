class ShippingMailer < ActionMailer::Base
  default from: 'tradeartcollective@gmail.com'

  def item_sold_email(sale)
    @sale = sale
    mail(to: @sale.user.email, subject: 'Your item has been sold!')
  end

  def shipping_email(sale)
    @sale = sale
    mail(to: @sale.payer_email, subject: 'Your item has been shipped!')
  end

  def refund_payment_email(sale)
    @sale = sale
    mail(to: @sale.payer_email, subject: 'You have been refunded!')
  end
end
