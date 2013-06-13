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
  attr_accessible :title, :duration, :copyright_date, :work_claims_attributes, :audio_products_attributes

  validates :title, presence: true
  before_save { title.upcase! }
  after_validation { mr_share_errors if errors.include?(:"work_claims.mr_share") }

  private

    def mr_share_errors
      errors.delete(:"work_claims.mr_share")
      errors.add(:your_share, "cannot be blank")
    end
end
