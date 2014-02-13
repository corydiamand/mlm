require 'spec_helper'

describe Admin::WorksController do
	Admin::WorksController.skip_filter :signed_in_user, :admin_user, :pending_count

	before :each do 
		@request.env['HTTP_REFERER'] = 'http://localhost:3000/admin_works'
		@work = FactoryGirl.create(:work)
	end

	after :all do 
		Admin::WorksController.before_filter :signed_in_user, :admin_user, :pending_count
	end

	describe "Delete destroy" do

		it "lowers the number of users by 1" do
			first_count = Work.count
			delete :destroy, id: @work.id, format: "1"
			second_count = Work.count
			first_count.should eq(1)
			second_count.should eq(0)
		end

		it "redirects to all user page" do 
		end 
	end 
end