# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string(255)      default(""), not null
#  encrypted_password     :string(255)      default(""), not null
#  reset_password_token   :string(255)
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string(255)
#  last_sign_in_ip        :string(255)
#  confirmation_token     :string(255)
#  confirmed_at           :datetime
#  confirmation_sent_at   :datetime
#  unconfirmed_email      :string(255)
#  first_name             :string(255)
#  last_name              :string(255)
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#

class User < ActiveRecord::Base
      
  VALID_EMAIL_REGEX = Regexp.new(/\A[\w\d\.-]+@(?:\w+\.)+[\w]{2,}\Z/i)
  VALID_USERNAME_REGEX = Regexp.new(/\A\w+[\d\w\-\_]*\Z/i)
  
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise(:database_authenticatable, :registerable, :recoverable, :rememberable,
         :trackable, :validatable, :confirmable, :authentication_keys=>[:login])

  # Setup accessible (or protected) attributes for your model
  attr_accessible :username, :email, :password, 
                  :password_confirmation, :remember_me,
                  :first_name, :last_name, :login
                  
  attr_accessor :login
  
  validates :username, :presence => true, :uniqueness => {
    :message => "%{value} is already registered.",
    :case_sensitive => false
  }

  validates :email, :presence => true, 
            :format => { :with => VALID_EMAIL_REGEX },
            :uniqueness => { :case_sensitive => false }

  validates :password,
            :presence => true,
            :length => { :minimum => 6 },
            :on => :create

  validates :username, :presence => true,
            :format => { :with => VALID_USERNAME_REGEX },
            :on => :create, 
            :on => :update
  
  has_many :events
  
  searchable do
    text :username, :first_name, :last_name
#     text :events do
#       events.map { |event| event.title }
#     end
  end
  
  def self.default
    self.new(:email => "", :password => "", :username => "")
  end
    
  def self.find_first_by_auth_conditions(warden_conditions)
    debugger
    conditions = warden_conditions.dup
    if login = conditions.delete(:login)
      where(conditions).where(
        ["username = :value OR lower(email) = lower(:value)",
          { :value => login.downcase }]
      ).first
    else
      where(conditions).first
    end
  end
  
  def self.find_for_database_authentication(warden_conditions)
    debugger
    conditions = warden_conditions.dup
    if login = conditions.delete(:login)
      where(conditions).where(
        ["username = :value OR lower(email) = lower(:value)",
          { :value => login.downcase }]
      ).first
    else
      where(conditions).first
    end
  end
  
  def self.search(_keywords)
    search = Sunspot.search(User) do
      keywords _keywords
    end
    @results = search.results 
  end
  
  # def email_required?
#     false
#   end
#   
  def full_name
    "#{self.first_name} #{self.last_name}"
  end
  

end
