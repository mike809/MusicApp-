class ApplicationController < ActionController::Base
  protect_from_forgery
  
  include UsersHelper
  include EventsHelper
  include ApplicationHelper
  
#  before_filter :authenticate_user!
  before_filter :configure_devise_params, if: :devise_controller?
  
  protected
  
  def configure_devise_params
      devise_parameter_sanitizer.for(:sign_up) do |u|
        u.permit(:username, :email, 
                 :password, :password_confirmation, 
                 :remember_me, :first_name, :last_name) 
      end
      
      devise_parameter_sanitizer.for(:sign_in) do |u|
        u.permit(:login, :password, :remember_me)
      end
      devise_parameter_sanitizer.for(:account_update) do |u|
        u.permit(:username, :email, :password, :password_confirmation,
                 :current_password, :first_name, :last_name) 
      end
    end
end
