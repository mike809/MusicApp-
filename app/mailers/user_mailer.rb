require 'addressable/uri'
  
class UserMailer < ActionMailer::Base
  default from: "non-reply@musicapp.com"
  
  def welcome_email(user)
    @user = user
    @url  = 'http://localhost:3000/login'
    mail(to: user.email, subject: 'Welcome to My Awesome Site')
  end
  
  def reset_password_email(user)
    @user = user
    @url = Addressable::URI.new(
      :scheme => "http",
      :host => "localhost:3000",
      :path => "new_password",
      :query_values => { :token => @user.reset_password_token! }
    ).to_s
    @user.save
    mail(:to => @user.email, :subject => 'Reset your Socialize password')
  end
  
end
