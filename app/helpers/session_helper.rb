module SessionHelper
  
  def current_user
    @current_user ||= User.find_by_session_token(session[:session_token])
  end
  
  def current_user?(user)
    current_user == user
  end
    
  def logged_in?
    current_user
  end
  
  def login(user)
    user.reset_session_token!
    user.save!
    session[:session_token] = user.session_token
    @current_user = user
  end
  
  def log_out!
    user = User.find_by_session_token(session[:session_token])
    user.reset_session_token!
    user.save!
    session[:session_token] = nil
  end  
  
end
