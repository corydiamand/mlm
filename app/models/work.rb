# == Schema Information
#
# Table name: works
#
#  id               :integer          not null, primary key
#  user_id          :integer
#  audio_product_id :integer
#  work_title       :string(255)
#  duration         :string(255)
#  copyright_date   :string(255)
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#

class Work < ActiveRecord::Base
  belongs_to :user
  attr_accessible :work_title, :duration, :copyright_date

  validates :user_id, presence: true
end
