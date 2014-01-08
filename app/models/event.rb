# == Schema Information
#
# Table name: events
#
#  id          :integer          not null, primary key
#  user_id     :integer
#  title       :string(255)
#  description :string(255)
#  location    :string(255)
#  minimum_age :integer
#  poster      :binary
#  rate        :integer
#  date        :date
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Event < ActiveRecord::Base
  attr_accessible :date, :description, :location, :user_id,
                  :minimum_age, :poster, :rate, :title
      
  validates :date, :poster, :user_id, :location, :minimum_age, 
            :title, :presence => true
            
  before_validation :init_rate
  
  belongs_to :user
  
  def init_rate
    self.rate = 0
  end
  
  def self.search(keywords)
    Event.where("lower(title) LIKE ? OR lower(description) LIKE ? OR \
                lower(location) LIKE ?",  *(["%#{keywords.downcase}%"])) || []
  end
end
