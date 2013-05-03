require 'spec_helper'

describe "PasswordResetsPages" do
  let(:user) { FactoryGirl.create(:user) }

  context "before request for email" do
    before do
      visit root_path
      click_link 'Forgot Password?'
    end

    it "should render the email page" do
      page.should have_selector('h2', text: 'Reset Password')
    end

    it "should render notice after reset request" do
      fill_in 'Email',   with: user.email
      click_button 'Reset Password'
      page.should have_content('password reset instructions')
      current_path.should == root_path
    end
  end

  context "after request for email" do
    before do
      request_new_password_ui(user)
      visit edit_password_reset_path(user.password_reset_token)
    end
    let(:short_password) { "a" * 5 }

    it "should render the reset form" do
      page.should have_selector('h2', text: 'Reset Password')
    end

    it "should display an error message without confirmation" do
      fill_in "user_password",  with: user.password
      click_button "Update Password"
      page.should have_content "Password doesn't match confirmation"
    end

    it "should display an error message if length is too short" do
      fill_in "user_password",  with: short_password
      fill_in "Password confirmation",  with: short_password
      click_button "Update Password"
      page.should have_content "Password is too short"
    end

    it "should render the update" do
      old_password = user.password
      fill_in "user_password",  with: "newpassword"
      fill_in "Password confirmation",  with: "newpassword"
      click_button "Update Password"
      page.should have_content "Password has been reset"
    end

    it "fails when password token has expired" do
      user.update_attributes!(password_reset_sent_at: 5.hours.ago)
      fill_in "user_password",  with: user.password
      fill_in "Password confirmation",  with: user.password
      click_button "Update Password"
      page.should have_content "Password reset has expired"
    end

    it "renders a invalid record page with wrong edit user path" do
      expect do
        visit edit_password_reset_path('invalid')
      end.to raise_error(ActionView::Template::Error)
    end
  end
end
