class UsersController < ApplicationController
  
  def show
    @user = User.friendly_id.find(params[:id])
  
    if @user.nil?
      flash_msg("User #{params[:user_id]} does not exist.")
      redirect_to login_url
    else
      render :show
    end  
  end

end