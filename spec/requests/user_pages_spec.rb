require 'spec_helper'

describe 'User Pages' do
	before(:all) { @user = FactoryGirl.create(:user) }
	after(:all) { @user.destroy}

	subject { page }

	describe "while logged in" do
		before { sign_in @user }

		it { should have_link('Sign out') }

		describe "should be able to log out" do
			before { click_link "Sign out" }

			it { should have_link('Sign in') }
		end
	end
end


