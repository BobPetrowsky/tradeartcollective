class ItemsController < ApplicationController
  def new
    @item = Item.new
  end

  def index
    @items = Item.all
  end

  def show
    @item = Item.find(params[:id])
    @user = User.find(params[:user_id])
  end

  def create
    @user = User.find(params[:user_id])
    @item = @user.items.new(item_params)
    if @item.save
      flash[:notice] = 'Item added!'
      redirect_to @user
    else
      flash[:notice] = 'Could not save.'
      render :new
    end
  end

  def edit
    @user = current_user
    @item = @user.items.find(params[:id])
  end

  def update
    @user = current_user
    @item = @user.items.find(params[:id])
    if @item.update(item_params)
      flash[:notice] = 'Item Updated!'
    else
      flash[:notice] = 'Could not update.'
      render :edit
    end
  end

  def destroy
    @item = Item.find(params[:id])
    @user = current_user
    @item.destroy
    flash[:notice] = 'This item has been removed.'
    redirect_to @user
  end

  # GET /users/buy/1
  def buy
    @item = Item.find(params[:item_id])
    @user = @item.user
    redirect_uri = url_for(:controller => 'users', :action => 'payment_success', :user_id => params[:user_id], :item_id => params[:item_id], :host => request.host_with_port)

    begin
      @checkout = @item.create_checkout(redirect_uri)
    rescue Exception => e
      redirect_to @user, alert: e.message
    end
  end

  def relist_item
    @user = current_user
    @item = Item.find(params[:item_id])
    @item.sold = false
    if @item.save
      redirect_to user_sales_path(@user), notice: "Item relisted!"
    else
      redirect_to user_sales_path(@user), notice: "Could not relist, please try again!"
    end
  end

  private

  def item_params
    params.require(:item).permit(:user_id, :name, :price, :img, :description)
  end
end
