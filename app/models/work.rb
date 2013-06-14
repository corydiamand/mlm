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
  has_many :work_claims, inverse_of: :work
  has_many :users, through: :work_claims
  has_many :audio_products, inverse_of: :work
  accepts_nested_attributes_for :work_claims
  accepts_nested_attributes_for :audio_products, reject_if: lambda { |a| a[:album].blank? }
  attr_accessible :title, :duration, :copyright_date_string, :work_claims_attributes, 
                  :audio_products_attributes
  attr_accessor :copyright_date_string

  validates :title, presence: true
  before_save { title.upcase! }
  before_save { convert_string_to_copyright_date if copyright_date_string.present? }

  private

  def convert_string_to_copyright_date
    self.copyright_date = Date.strptime("#{copyright_date_string}", "%m/%d/%Y")
  end
end
