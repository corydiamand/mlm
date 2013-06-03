# == Schema Information
#
# Table name: statements
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  quarter    :string(255)
#  year       :string(255)
#  amount     :float
#  filename   :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  date       :string(255)
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

  before_save { convert_string_to_date }

  private

    def convert_string_to_date
      self.date = Date.strptime(self.date, "%m/%d/%Y")
    end
end
