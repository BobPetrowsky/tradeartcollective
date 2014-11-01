class LandingController < ApplicationController

  def show
    @users = User.all.includes(:items)
  end
end
