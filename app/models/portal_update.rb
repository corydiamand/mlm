# == Schema Information
#
# Table name: portal_updates
#
#  id         :integer          not null, primary key
#  date       :datetime
#  user_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class PortalUpdate < ActiveRecord::Base
  belongs_to :user
  attr_accessible :date, :user_id
end
