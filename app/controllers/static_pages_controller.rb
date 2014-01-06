class StaticPagesController < ApplicationController
  
  skip_before_filter :authenticate_user!
  
  def home
    @user = current_user
    unless @user.nil?
      @events = @user.events
      if user_signed_in?
        render template: "events/index"
      else
        render :home
      end
    else
      render :home
    end
  end
  
end
