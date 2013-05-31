# == Schema Information
#
# Table name: statements
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  quarter    :string(255)
#  year       :string(255)
#  amount     :integer
#  filename   :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Statement < ActiveRecord::Base
  belongs_to :user
  attr_accessible :user_id, :amount, :filename, :quarter, :year, :date
  default_scope order('date DESC')

  validates :user_id, presence: true
  validates :filename, presence: true
  validates :quarter, presence: true
  validates :year, presence: true
  validates :amount, presence: true
  validates :date, presence: true
end
