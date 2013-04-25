require 'spec_helper'

describe "PasswordResetsPages" do
  before(:all) { @user = FactoryGirl.create(:user) }
  after(:all) { @user.destroy }

  context "before request for email" do
    before do
      visit root_path
      click_link 'Forgot Password?'
    end

    it "should render the email page" do
      page.should have_selector('h2', text: 'Reset Password')
    end

    it "should render notice after reset request" do
      fill_in 'Email',   with: @user.email
      click_button 'Reset Password'
      page.should have_content('password reset instructions')
      current_path.should == root_path
    end
  end

  context "after request for email" do
    before do
      request_new_password(@user)
      visit edit_password_reset_path(@user.password_reset_token)
    end

    it "should render the reset form" do
      page.should have_selector('h2', text: 'Reset Password')
    end
  end
end
