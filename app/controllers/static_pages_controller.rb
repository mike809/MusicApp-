class StaticPagesController < ApplicationController
  skip_before_filter :require_login
  
  def home
    @user = current_user
    unless @user.nil?
      @events = @user.events
      if logged_in?
        render template:"events/index"
      else
        render :home
      end
    else
      render :home
    end
  end
  
end
