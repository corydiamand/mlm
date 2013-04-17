require 'spec_helper'

describe 'User Pages' do
	let(:user) { FactoryGirl.create(:user) }

	subject { page }

	describe "User page" do
		before { sign_in user }
		
		it {should have_link('Sign out') }
	end
end

