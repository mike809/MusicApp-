class Event < ActiveRecord::Base
  attr_accessible :date, :description, :location, :minimum_age, :poster, :rate, :title
end
