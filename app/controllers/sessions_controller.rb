class SessionsController < ApplicationController

  skip_before_filter :require_login, :except => :destroy
  before_filter :require_not_login, :only => [:new, :create]
  
  def new
    @user = User.default
    render :login
  end
  
  def create
    default_value = params[:user][:email]
    password = params[:user][:password]
    type_of_credential = User.username_or_email(default_value)
    email = default_value
    
    if type_of_credential == :username
      user = User.find_by_username(email)
      if user
        email = user.email
      else
        flash_now("Username does not exist.")
        @user = User.default
        @user.email = default_value
        render :login
        return
      end
    end
    
    @user = User.find_by_credentials(email, password)
      
    if @user.nil?
      flash_now("Credentials do not match.")
      @user = User.default
      @user.email = default_value
      render :login
    else
      self.login(@user)
      redirect_to user_url(@user)
    end
  end
  
  def destroy
    self.log_out!
    redirect_to login_url
  end
  
end
