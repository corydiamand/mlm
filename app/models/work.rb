# == Schema Information
#
# Table name: works
#
#  id               :integer          not null, primary key
#  audio_product_id :integer
#  title            :string(255)
#  duration         :string(255)
#  copyright_date   :string(255)
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  fmp_work_id      :integer
#

class Work < ActiveRecord::Base
  belongs_to :user
  attr_accessible :title, :duration, :copyright_date
end