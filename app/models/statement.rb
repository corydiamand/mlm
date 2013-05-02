class Statement < ActiveRecord::Base
  attr_accessible :amount, :filename, :quarter, :user_id, :year
end
