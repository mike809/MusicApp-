class SearchController < ApplicationController
  
  skip_before_filter :authenticate_user!
  
  def create
    @users = User.search(params[:search_keywords])
    @events = Event.search(params[:search_keywords])
              
    render :results
  end
  
end
