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

require 'spec_helper'

describe Statement do
  pending "add some examples to (or delete) #{__FILE__}"
end
