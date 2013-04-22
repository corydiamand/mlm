require 'spec_helper'

describe 'User Pages' do
	before(:all) do
		@user = FactoryGirl.create(:user) 
		@admin = FactoryGirl.create(:admin)
		@user2 = FactoryGirl.create(:user)
		@user3 = FactoryGirl.create(:user)
		@users = [@user, @user2, @user3]
	end
	
	after(:all) do
		@admin.destroy
		@users.each do | user|
			user.destroy
		end
	end

	subject { page }

	describe "while logged in" do
		before { sign_in @user }

		it { should have_link('Sign out') }

		describe "should be able to log out" do
			before { click_link "Sign out" }

			it { should have_link('Sign in') }
		end

		describe "it should link to user's update path" do
			it { should have_link('My Account', href: edit_user_path(@user.id)) } 
		end
	end

	describe "index pages" do

		describe "as an admin" do
			before { sign_in @admin }

			it "should redirect to the index page" do
				page.should have_selector('div.pagination')
			end

			describe "pagination" do
				before { visit users_path }

				it "should list each user" do
				 	@users.each do |user|
				    	page.should have_selector("li", content: user.first_name)
				    	page.should have_selector("li", content: user.last_name)  
				    end
				end
			end

			describe "should lead to a user's page" do
				before do
					visit users_path
					visit user_path(@user.id)
				end
				it { should have_selector('h2', content: @user2.first_name) }
			end
		end

		describe "as a non admin" do
			before do
				sign_in @user
				get users_path
			end

			specify { response.should redirect_to(root_path) }
		end
	end
end


