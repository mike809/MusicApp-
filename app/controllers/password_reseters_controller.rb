class PasswordResetersController < ApplicationController
  
  skip_before_filter :require_login
  before_filter :require_not_login
  
  def new
    render :new
  end
  
  def create
    type_of_credential = User.username_or_email(params[:user][:email])
    if type_of_credential == :username
      email = User.find_by_username(params[:user][:email]).email
    end
    
    default_value = params[:user][:email]
    @user = User.find_by_email(email)
    
    if @user
      msg = UserMailer.reset_password_email(@user)
      msg.deliver!
      redirect_to home_url
    else
      flash_now("Email invalid.")
      @user.email = default_value
      render :new
    end
  end
  
  def edit #set new password
    
  end
  
  def destroy
    
  end
  
end
