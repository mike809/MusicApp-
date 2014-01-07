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
  
#   searchable do
#     text :title, :description
#     # text :comments do
# #       comments.map { |comment| comment.body }
# #     end
#     text :location
#   end
  
  def init_rate
    self.rate = 0
  end
  
  def self.search(keywords)
    Event.where("title LIKE :val OR description LIKE :val OR \
                location LIKE :val", {:val => "%#{keywords}%"}) || []
  end
end
