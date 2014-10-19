class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :null_session
  helper_method :current_user
  helper_method :on_page

  private

  def on_page
    if params[:id] || params[:user_id] || params[:item_id] || params[:checkout_id]
      return false
    else
      return true
    end
  end

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
end
