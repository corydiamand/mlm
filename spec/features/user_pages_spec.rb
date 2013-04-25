require 'spec_helper'

describe "User Pages" do
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

  context "as a non-admin" do
    before do
      visit root_path
      sign_in @user
    end

    it "should be able to sign in" do
      page.should have_selector('h2', text: @user.first_name)
      page.should have_link 'Sign out'
      page.should have_link('My Account', href: edit_user_path(@user.id))
    end

    it "should change the logo path" do
      click_link 'logo'
      page.should have_selector('h2', text: @user.first_name)
    end

    it "should be able to edit his/her information" do
      visit edit_user_path(@user.id)
      page.should have_selector('h2', text: 'Update your account')
      fill_in "First name",            with: "New Name"
      fill_in "Email",                 with: "new@example.com"
      fill_in "Password",              with: "foobar"
      fill_in "Confirm password",      with: "foobar"
      click_button "Save changes"
      page.should have_selector('div.alert.alert-success')
      @user.reload.first_name.should == "New Name"
      @user.reload.email.should == "new@example.com"
    end

    it "should not be able to edit information without credentials" do
      visit edit_user_path(@user.id)
      fill_in "First name",            with: "Name without password"
      fill_in "Email",                 with: "email@nopassword.com"
      click_button "Save changes"
      page.should have_content('error') 
    end

    it "should not be able to view the users list" do
      visit users_path
      page.should have_selector('h2', text: 'Missing Link Music Client Portal')
    end

    it "should not be able to access another user's page" do
      visit user_path(@other_user.id)
      page.should_not have_selector('h2', text: @other_user.first_name)
    end

    it "should be able to sign out" do
      click_link 'Sign out'
      page.should have_selector('h2', text: 'Missing Link Music Client Portal')
      page.should have_link 'Sign in'
    end
  end

  context "as an admin" do
    before do
      visit root_path
      sign_in @admin
    end

    it "should be able to sign in" do
      page.should have_selector('div.pagination')
    end

    it "should be able to visit a users page" do
      visit user_path(@user.id)
      page.should have_selector('h2', @user.first_name)
    end

    it "should be able to sign out" do
      click_link 'Sign out'
      page.should have_selector('h2', text: 'Missing Link Music Client Portal')
      page.should have_link 'Sign in'
    end
  end


end