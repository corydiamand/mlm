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

require 'spec_helper'

describe Session do
	let(:session) { FactoryGirl.create(:session) }

	subject { session }

	it { should respond_to(:id) }
	it { should respond_to(:login) }
	it { should respond_to(:logout) }
	it { should respond_to(:user_id) }
	it { should respond_to(:length) }

describe "Methods" do

	it "should convert logout timestamp to EST and then string format" do 
		session.login_to_est.should_not == session.login
	end

	it "should convert logout timestamp to EST and then string format" do 
		session.logout_to_est.should_not == session.logout
	end

	it "should convert logout timestamp to EST" do 
	end

	it "should return a length" do
        session.length.should_not == nil
        session.length.should > 0
    end
end

end
