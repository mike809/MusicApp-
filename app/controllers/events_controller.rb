class EventsController < ApplicationController
  
  def show
    @user = User.find(params[:user_id])
    @event = Event.find(params[:id])
    render :show
  end
  
  def show_image
    @event = Event.find(params[:id])
    send_data @event.poster, :type => 'image/png',:disposition => 'inline'
  end
  
  def new
    render :new
  end
  
  def create
    date = DateTime.new(*parse_datetime(params[:event]))
    params[:event][:date] = date
    params[:event][:user_id] = params[:user_id]
    params[:event][:poster] = params[:event][:poster].read
    
    @event = Event.create(params[:event])
    
    if @event.save
      redirect_to user_event_url(@event.user_id, @event)
    else
      flash_now(@event.errors.full_messages)
      render :new
    end
  end
  
  def index
    @user = User.find(params[:user_id])
    @events = current_user.events
    render :index
  end
  
  def edit
    
  end
  
  def update
    
  end
  
  def user_index
    
  end
  
end
