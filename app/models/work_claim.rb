# == Schema Information
#
# Table name: work_claims
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  work_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  mr_share   :integer
#

class WorkClaim < ActiveRecord::Base
  belongs_to :user
  belongs_to :work
  attr_accessible :user_id, :work_id, :mr_share

  validates :user_id, presence: true
  validates :work_id, presence: true
end
