class AboutsController < ApplicationController
  def edit
    @user = current_user
    @about = About.find(params[:id])
  end

  def update
    @about = About.find(params[:id])
    @user = current_user
    if @about.update(about_params)
      redirect_to @user, notice: 'Updated'
    else
      flash[:notice] = 'Could not update.'
      render user_path(@user)
    end
  end

  private

  def about_params
    params.require(:about).permit(:user_id, :name, :location, :image, :story)
  end

end
