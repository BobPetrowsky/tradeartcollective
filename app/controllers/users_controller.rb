class UsersController < ApplicationController

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
  end

  def checkouts
    @user.checkouts
  end

  # GET /users/oauth/1
  def oauth
    if !params[:code]
      return redirect_to('/')
    end

    redirect_uri = url_for(:controller => 'users', :action => 'oauth', :user_id => params[:user_id], :host => request.host_with_port)
    @user = User.find(params[:user_id])
    begin
      @user.request_wepay_access_token(params[:code], redirect_uri)
    rescue Exception => e
      error = e.message
    end

    if error
      redirect_to @user, alert: error
    else
      redirect_to @user, notice: 'We successfully connected you to WePay!'
    end
  end

  def payment_success
    @user = User.find(params[:user_id])
    @item = Item.find(params[:item_id])
    @checkout_id = params[:checkout_id]
    if !params[:checkout_id]
      return redirect_to user_path(@user), alert: "Error - Checkout ID is expected"
    end
    if (params['error'] && params['error_description'])
      return redirect_to user_path(@user), alert: "Error - #{params['error_description']}"
    end
    @item.sold = true
    @item.save
    response = TradeArtCollective::Application::WEPAY.call('/checkout', @user.wepay_access_token, {
      :checkout_id => @checkout_id
    })
    @sale = Sale.create_from_wepay(response, @user, @item)
    redirect_to user_path(@user), notice: "Thanks for the payment! You should receive a confirmation email shortly."
  end
end
