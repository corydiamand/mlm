# == Schema Information
#
# Table name: sessions
#
#  id         :integer          not null, primary key
#  login      :datetime
#  logout     :datetime
#  user_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Session < ActiveRecord::Base
  belongs_to :user
  attr_accessible :login, :logout

  def length
  	logout - login
  end
end
