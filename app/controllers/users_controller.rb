class UsersController < ApplicationController
  
  skip_before_filter :authenticate_user!, :only => [:new, :create]
  
  def new
    @user = User.default
    render :signup
  end
  
  def create
    @user = User.new(params[:user])
    if @user.save
      self.login(@user)
      redirect_to user_url(@user)
    else
      flash_now(@user.errors.full_messages)
      render :signup
    end
  end
  
  def show
    @user = User.find_by_id(params[:id])
  
    if @user.nil?
      flash_msg("User #{params[:user_id]} does not exist.")
      redirect_to login_url
    else
      render :show
    end  
  end
  
  def edit
    @user = current_user
    render :edit
  end
  
  def update
    user_password = User.find_by_password_reset_token(session[:password_token])
    session[:password_token] = nil 
    
    @user = current_user 
    @user ||= user_password 
    
    if @user.confirm_password(params[:user][:password]) ||
          @user.password_reset_token
          
      @user.password_reset_token = nil
      if @user.update_attributes(params[:user])
        flash_msg("Information successfuly updated.", :success)
        login(@user)
        redirect_to user_url(@user)
      else
        flash_now(@user.errors.full_messages)
        render :edit
      end
    else
      flash_now("Incorrect Password.")
      render :edit
    end
  end
  
end