require 'spec_helper'

describe "User Pages" do
	before(:all) do
    @user = FactoryGirl.create(:user)
    @admin = FactoryGirl.create(:admin)
  end

	after(:all) do 
    @user.destroy 
    @admin.destroy
  end

  context "as a non-admin" do
    before do
      visit root_path
      sign_in @user
    end

  	it "should be able to log in" do
  		page.should have_selector('h2', text: @user.first_name)
  		page.should have_link 'Sign out'
  		page.should have_link('My Account', href: edit_user_path(@user.id))
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
