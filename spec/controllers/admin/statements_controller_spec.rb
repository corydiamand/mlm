require 'spec_helper'

describe Admin::StatementsController do
	let!(:admin) { FactoryGirl.create(:admin) }


	describe "Delete destroy" do
		#@statement = FactoryGirl.create(:statement)

	before :each do 
		FactoryGirl.create(:admin)
		@statement = FactoryGirl.create(:statement)
	end

		it "lowers the number of statements by 1" do
			first_count = Statement.count
			puts Statement.all.inspect
			puts @statement.inspect
			delete :destroy, id: 1
			delete "destroy", :id => 1
			puts response.body
			#@statement.destroy
			second_count = Statement.count
			first_count.should eq(1)
			second_count.should eq 0
		end

		it "redirects to all statement page" do 
			#delete :destroy, id: @statement 
			#response.should redirect_to admin_statements_url 
		end 
	end 
end
