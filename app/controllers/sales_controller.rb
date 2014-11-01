class SalesController < ApplicationController

  def index
    @user = current_user
  end

  def mark_as_shipped
    @sale = Sale.find(params[:sale_id])
    @sale.shipped = true
    if @sale.save
      redirect_to user_sales_path(current_user), notice: "Item marked as shipped!"
      ShippingMailer.shipping_email(@sale).deliver
    else
      flash[:notice] = "Could not mark as shipped, please try again"
      render :index
    end
  end

  def refund_payment
    @user = current_user
    @sale = Sale.find(params[:sale_id])
    @sales = @user.sales
    TradeArtCollective::Application::WEPAY.call('/checkout/refund', @user.wepay_access_token, {
      :checkout_id => @sale.checkout_id,
      :refund_reason => "Refunded by seller"
    })
    response = response = TradeArtCollective::Application::WEPAY.call('/checkout', @user.wepay_access_token, {
      :checkout_id => @sale.checkout_id
    })
    if response["state"] == "refunded"
      @sale.refunded = true
      @sale.save!
      redirect_to user_sales_path(@user), notice: "Item refunded!"
      ShippingMailer.refund_payment_email(@sale).deliver
    else
      flash[:notice] = "Could not refund, please try again"
      render :index
    end
  end

end
