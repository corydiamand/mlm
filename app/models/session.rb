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
  attr_accessible :login, :logout, :user_id

  def login_to_est
  	if login != nil
  		(login + Time.zone_offset('EST')).strftime("%b %e, %l:%M%p %y'")
  	else
  		"None"
  	end
  end

   def logout_to_est
  	if logout != nil
  		(logout + Time.zone_offset('EST')).strftime("%b %e, %l:%M%p %y'")
  	else
  		"Logout Not Captured"
  	end
  end

  def length
  	if login != nil && logout != nil
  	(logout.to_i - login.to_i)/60
  	else
  		"?"
  	end
  end

end
