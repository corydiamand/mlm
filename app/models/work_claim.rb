# == Schema Information
#
# Table name: work_claims
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  work_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  mr_share   :float
#  web_id     :integer
#

class WorkClaim < ActiveRecord::Base
  belongs_to :user, :foreign_key => "web_id", :primary_key => "web_id", inverse_of: :work_claims
  belongs_to :work, inverse_of: :work_claims
  attr_accessible  :work_id, :mr_share, :web_id #,:user_id

  validates_presence_of :work, :mr_share, :web_id
  validates :mr_share, numericality: { greater_than: 0, less_than_or_equal_to: 100 }

end
