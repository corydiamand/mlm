# == Schema Information
#
# Table name: audio_products
#
#  id             :integer          not null, primary key
#  work_id        :integer
#  artist         :string(255)
#  album          :string(255)
#  label          :string(255)
#  catalog_number :string(255)
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#
# Indexes
#
#  index_audio_products_on_work_id  (work_id)
#

class AudioProduct < ActiveRecord::Base
  belongs_to :work, inverse_of: :audio_products
  attr_accessible :work_id, :artist, :album, :label, :catalog_number

  validates_presence_of :work

  before_save { artist.upcase! }
  before_save { album.upcase! }
  before_save { label.upcase! }
end
