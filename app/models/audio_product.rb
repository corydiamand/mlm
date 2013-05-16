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

class AudioProduct < ActiveRecord::Base
  belongs_to :work

  validates :work_id, presence: true
end
