# == Schema Information
#
# Table name: works
#
#  id             :integer          not null, primary key
#  title          :string(255)
#  duration       :string(255)
#  copyright_date :string(255)
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#

class Work < ActiveRecord::Base
  has_many :work_claims
  has_many :users, through: :work_claims
  has_many :audio_products
  accepts_nested_attributes_for :work_claims 
  accepts_nested_attributes_for :audio_products
  attr_accessible :title, :duration, :copyright_date, :work_claims_attributes, :audio_products_attributes

  before_save { title.upcase! }

end
