# == Schema Information
#
# Table name: albums
#
#  id            :integer          not null, primary key
#  title         :string(255)
#  band_id       :integer          not null
#  type_of_album :string(255)
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

class Album < ActiveRecord::Base
  attr_accessible :title, :band_id, :type_of_album
  
  has_many :tracks,
           :class_name => "Track",
           :foreign_key => :album_id,
           :primary_key => :id,
           :dependent => :destroy
           
  belongs_to :band,
             :class_name => "Band",
             :foreign_key => :band_id,
             :primary_key => :id
             
end
