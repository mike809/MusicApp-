# == Schema Information
#
# Table name: users
#
#  id                   :integer          not null, primary key
#  email                :string(255)      not null
#  password_digest      :string(255)      not null
#  session_token        :string(255)      not null
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#  username             :string(255)
#  password_reset_token :string(255)
#  reset_password       :datetime
#  first_name           :string(255)
#  last_name            :string(255)
#

class User < ActiveRecord::Base
  
  VALID_EMAIL_REGEX = Regexp.new(/\A[\w\d\.-]+@(?:\w+\.)+[\w]{2,}\Z/i)
  VALID_USERNAME_REGEX = Regexp.new(/\A\w+[\d\w\-\_]*\Z/i)
  
  attr_accessible :email, :password, :username,
                  :first_name, :last_name, :new_password
                  
  attr_reader :password, :new_password
  
  validates :username, :presence => true, :uniqueness => {
    :message =>  "%{value} is already registered."
  }

  validates :session_token, :uniqueness => true
  
  validates :email, :presence => true, 
            :format => { :with => VALID_EMAIL_REGEX },
            :uniqueness => { :case_sensitive => false }

  validates :password,
            :presence => true,
            :length => { :minimum => 6 },
            :on => :create

  validates :new_password, :length => { :minimum => 6 }, :allow_blank => true,
            :on => :update
  
  validates :username, :presence => true,
            :format => { :with => VALID_USERNAME_REGEX },
            :uniqueness => { :case_sensitive => false },
            :on => :create, 
            :on => :update
  
  before_validation :reset_session_token!,
                    :on => :create
  
  has_many :events
  
  def self.default
    self.new(:email => "", :password => "", :username => "")
  end
  
  def self.find_by_credentials(email, plain_text_pw)
    user = User.find_by_email(email)
    return nil if user.nil? 
    is_password?(user, plain_text_pw) ? user : nil
  end
  
  def self.is_password?(user, password)
    BCrypt::Password.new(user.password_digest) == password
  end
  
  def self.username_or_email(username_or_email)
    if username_or_email =~ VALID_EMAIL_REGEX
      return :email
    end
    :username
  end

  def confirm_password(password)
    User.is_password?(self, password)
  end
  
  def new_password=(new_password)
    @new_password = new_password
    debugger
    password = new_password unless @new_password.blank?
  end
  
  def password=(password)
    @password = password
    self.password_digest = BCrypt::Password.create(password)
  end
  
  def reset_password_token!
    self.password_reset_token = SecureRandom.urlsafe_base64
  end
  
  def reset_session_token!
    self.session_token = SecureRandom.urlsafe_base64
  end
end
