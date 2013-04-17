require 'spec_helper'

describe "Authentication" do
	
	before(:all) { @user = FactoryGirl.create(:user) }
	after(:all) { @user.destroy }


	subject { page }

	describe 'with invalid information' do

		describe 'at the home page' do
			before { visit root_path }

			describe "should render the Signin page" do
				it { should have_selector('h3', text: "Sign in") }
			end

			describe "should not sign in the user" do
				before do
					fill_in "Email", 	 with: "Incorrect email"
					fill_in "Password",  with: "Incorrect password"
					click_button "Sign in"
				end

				describe "and re-render the page" do
					it { should have_selector('h3', text: "Sign in") }
				end

				describe "and render an flash error" do
					it { should have_selector('div.alert.alert-error', text: 'Invalid') }
				end
			end
		end
	end

	describe "with valid information" do

		describe "should sign in the user" do
			before { visit root_path }
			before { sign_in @user }

			describe "and redirect to the user show page" do
				it { should have_selector('h3', text: @user.first_name) }
				it { should have_selector('h3', text: @user.last_name) }
			end
		end

		describe "should be able to sign out" do
			before { sign_in @user }

			describe "submitting to the destroy action" do
				before { delete signout_path(@user) }
				specify { response.should redirect_to(root_path) }
			end
		end
	end
end