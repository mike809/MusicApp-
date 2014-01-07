# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
MusicApp::Application.initialize!

ActionMailer::Base.delivery_method = :smtp
config.action_mailer.default_url_options = { host: 'socialife.heroku.com' }
ActionMailer::Base.smtp_settings = {
  :address        => 'smtp.sendgrid.net',
  :port           => '587',
  :authentication => :plain,
  :user_name      => ENV['SENDGRID_USERNAME'],
  :password       => ENV['SENDGRID_PASSWORD'],
  :domain         => 'heroku.com',
  :enable_starttls_auto => true
}