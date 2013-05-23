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
  belongs_to :user, inverse_of: :work_claims
  belongs_to :work, inverse_of: :work_claims
  attr_accessible :user_id, :work_id, :mr_share

  validates_presence_of :user, :work
end
