require 'spec_helper'

describe "Authentication" do
  before(:all) do
    @user = FactoryGirl.create(:user)
    @other_user = FactoryGirl.create(:user)
    @admin = FactoryGirl.create(:admin)
  end
  
  after(:all) do 
    @user.destroy 
    @other_user.destroy
    @admin.destroy
  end

  context "with invalid information" do
    before do 
      visit root_path
      fill_in "Email",    with: "invalid@email.com"
      fill_in "Password", with: "invalid"
      click_button "Sign in"
    end

    it "should not be signed in" do
      page.should have_selector('h3', text: 'Sign in')
      page.should have_selector('div.alert.alert-error', text: 'Invalid')
    end

    it "should not be able to access a user page" do
      visit user_path(@user.id)
      page.should have_selector('h3', text: 'Sign in')
    end
  end

  context "with valid information" do
    before do
      visit root_path
      sign_in @user
    end

    it "should not be able to access another user's page" do
      visit user_path(@other_user.id)
      page.should_not have_selector('h2', text: @other_user.first_name)
    end
  end
end