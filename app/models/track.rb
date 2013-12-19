# == Schema Information
#
# Table name: tracks
#
#  id            :integer          not null, primary key
#  album_id      :integer          not null
#  title         :string(255)
#  type_of_track :string(255)
#  lyrics        :text
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

class Track < ActiveRecord::Base
  attr_accessible :title, :album_id, :type_of_track, :lyrics
  
  belongs_to :album,
             :class_name => "Album",
             :foreign_key => :album_id,
             :primary_key => :id
        
end
