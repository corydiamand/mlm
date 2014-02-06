class PortalUpdate < ActiveRecord::Base
  belongs_to :user
  attr_accessible :date, :user_id
end
