class BandsController < ApplicationController
  
  def index
    @bands = Band.all
    render :bands
  end
  
  def show
    @band = Band.find_by_id(params[:band_id])
    render :band
  end
  
  def new
    render :new_band
  end
  
  def create
    @band = Band.new(params[:band])
    
    if @band.save
      
    else
      
    end
  end
  
  def edit
  
  end
  
  def update
  
  end
  
  def destroy
  
  end
  
end
