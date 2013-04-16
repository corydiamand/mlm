require 'spec_helper'

describe 'User Pages' do
	before do
		@user = User.new(first_name: "Example", last_name: "User", email: "example@email.com", password: "foobar") 
	end

	subject { page }

	describe 'with invalid information' do

		describe 'at the home page' do
			before do
				@user.save!
				visit root_path
			end
			after { @user.destroy }

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

		describe "at the home page" do
			before do
				@user.save!
				visit root_path
			end
			after { @user.destroy }

			describe "should sign in the user" do
				before do
					fill_in "Email", 	 with: @user.email
					fill_in "Password",  with: @user.password
					click_button "Sign in"
				end

				describe "and redirect to the user show page" do
					specify { response.should redirect_to(user_path(@user)) }
					it { should have_selector('h3', @user.first_name) }
					it { should have_selector('h3', @user.last_name) }
				end
			end
		end
	end
end

