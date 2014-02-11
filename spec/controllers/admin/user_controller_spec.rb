require 'spec_helper'

describe Admin::UsersController do
	Admin::UsersController.skip_filter :signed_in_user, :admin_user, :pending_count

	before :each do 
		@request.env['HTTP_REFERER'] = 'http://localhost:3000/admin_users'
		@user = FactoryGirl.create(:user)
	end

	after :all do 
		Admin::UsersController.before_filter :signed_in_user, :admin_user, :pending_count
	end

	describe "Delete destroy" do

		it "lowers the number of users by 1" do
			first_count = User.count
			delete :destroy, id: @user.id
			second_count = User.count
			first_count.should eq(1)
			second_count.should eq(0)
		end

		it "redirects to all user page" do 
		end 
	end 
end