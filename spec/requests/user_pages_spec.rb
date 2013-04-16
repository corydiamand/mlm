require 'spec_helper'

describe 'User Pages' do
	before do
		@user = User.new(first_name: "Example", email: "example@email.com", last_name: "User", password: "foobar") 
	end

	subject { page }

	describe 'with logged-out user' do

		describe 'at the home page' do
			before do
				@user.save!
				visit root_path
			end
			after { @user.destroy }

			describe "should render the Signin page" do
				it { should have_selector('h3', text: "Sign in") }
			end

			describe "entering invalid information" do
				before do
					fill_in "Email", 	 with: "Incorrect email"
					fill_in "Password",  with: "Incorrect password"
					click_button "Sign in"
				end

				describe "should re-render the page" do
					it { should have_selector('h3', text: "Sign in") }
				end

				describe "should render an flash error" do
					it { should have_selector('div.alert.alert-error', text: 'Invalid') }
				end
			end
		end
	end
end

