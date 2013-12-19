class ApplicationController < ActionController::Base
  protect_from_forgery
  
  include SessionHelper
  include UsersHelper
  include ApplicationHelper
  
  before_filter :require_login
 
  private

  def require_login
    unless logged_in?
     flash_msg("You must be logged in to access this section.")
     redirect_to login_url
   end
  end
 
  def require_not_login
    if user = logged_in?
     redirect_to user_url(user)
   end
 end
 
end
