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

require 'test_helper'

class TrackTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
