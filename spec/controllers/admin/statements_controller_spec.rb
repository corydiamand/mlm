require 'spec_helper'

describe Admin::StatementsController do
	Admin::StatementsController.skip_filter :signed_in_user, :admin_user, :pending_count

	before :each do 
		@request.env['HTTP_REFERER'] = 'http://localhost:3000/admin_statements'
		@statement = FactoryGirl.create(:statement)
	end

	describe "Delete destroy" do

		it "lowers the number of statements by 1" do
			first_count = Statement.count
			delete :destroy, id: 1
			second_count = Statement.count
			first_count.should eq(1)
			second_count.should eq(0)
		end

		it "redirects to all statement page" do 
		end 
	end 
end
