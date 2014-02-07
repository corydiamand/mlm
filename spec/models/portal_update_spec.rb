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

require 'spec_helper'

describe PortalUpdate do
  	let(:portal_update) { FactoryGirl.create(:portal_update) }

	subject { portal_update}

	it { should respond_to(:id) }
	it { should respond_to(:date) }
	it { should respond_to(:user_id) }
	it { should respond_to(:created_at) }
	it { should respond_to(:updated_at) }
end
