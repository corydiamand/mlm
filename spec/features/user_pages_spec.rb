require 'spec_helper'

describe "User Pages" do
    let(:user) { FactoryGirl.create(:user) }
    let(:other_user) { FactoryGirl.create(:user) }
    let(:admin) { FactoryGirl.create(:admin) }
    let!(:statement) { FactoryGirl.create(:statement, user_id: user.id) }

  context "as a guest user" do
    
    it "should see the sign in page" do
      visit root_path
      page.should have_selector('title', 'MLM Portal') 
      page.should have_selector('h2', text: 'Missing Link Music Client Portal')
      page.should have_link('logo', href: root_path )
      page.should have_link('Forgot Password?', href: new_password_reset_path )
    end
  end

  context "with invalid information" do
    before do 
      visit root_path
      fill_in "Email",    with: "invalidemail.com"
      fill_in "Password", with: "invalid"
      click_button "Sign in"
    end

    it "should not be signed in" do
      page.should have_selector('h3', text: 'Sign in')
      page.should have_selector('div.alert.alert-error', text: 'Invalid')
    end

    it "should not be able to access a user page" do
      visit user_path(user)
      page.should have_selector('h3', text: 'Sign in')
    end
  end

  context "as a non-admin" do
    before { sign_in_through_ui user }

    it "should be able to sign in" do
      page.should have_selector('h2', text: user.first_name)
      page.should have_link 'Sign out'
      page.should have_link('My Account', href: edit_user_path(user))
      page.should have_link('My Royalties', href: user_path(user))
      page.should have_selector('section', text: "My Catalog")
      page.should have_link('View my catalog', href: user_works_path(user))
      page.should have_link('Submit new work', href: new_user_work_path(user))
    end

    it "should change the logo path" do
      click_link 'logo'
      page.should have_selector('h2', text: user.first_name)
    end

    it "should see his/her statements" do
      page.should have_selector('div.statement-table-header')
      page.find(:xpath, "//div[@id='#{statement.id}']")
      page.should have_selector('div', text: statement.quarter)
    end

    it "should see message if no statement data is found" do
      statement.destroy
      visit user_path user
      page.should have_content 'No statement data available'
    end

    it "should see the statement month" do
      page.should have_content(statement.date.strftime('%b %d'))
    end 

    it "should be able to edit his/her information" do
      visit edit_user_path(user)
      page.should have_selector('h2', text: 'Update your account')
      page.should have_link("Change my password", 
                            href: new_password_reset_path)
      fill_in "First name",            with: "NEW NAME"
      fill_in "Email",                 with: "new@example.com"
      fill_in "Password",              with: "foobar"
      fill_in "Confirm password",      with: "foobar"
      click_button "Save changes"
      page.should have_selector('div.alert.alert-success')
      user.reload.first_name.should == "NEW NAME"
      user.reload.email.should == "new@example.com"
    end

    it "should not be able to edit information without credentials" do
      visit edit_user_path(user)
      fill_in "First name",            with: "Name without password"
      fill_in "Email",                 with: "emailnopassword.com"
      click_button "Save changes"
      page.should have_content('error') 
    end

    it "should not be able to view the users list" do
      visit users_path
      page.should have_selector('h2', text: 'Missing Link Music Client Portal')
    end

    it "should not be able to access another user's page" do
      visit user_path(other_user)
      page.should_not have_selector('h2', text: other_user.first_name)
    end

    it "should not be able to access another user's works page" do
      visit user_works_path(other_user)
      page.should have_selector('h2', text: 'Missing Link Music Client Portal')
    end

    it "should be able to sign out" do
      click_link 'Sign out'
      page.should have_selector('h2', text: 'Missing Link Music Client Portal')
      page.should have_link 'Sign in'
      page.should_not have_link 'My Royalties'
    end
  end

  context "as an admin" do
    before { sign_in_through_ui admin }

    # it "should be able to sign in" do
    #   page.should have_selector('div.pagination')
    # end

    it "should be able to visit a users page and see his statements" do
      visit user_path user
      page.should have_selector('h2', user.first_name)
      page.should have_selector('div', statement.id)
    end

    it "should be able to sign out" do
      click_link 'Sign out'
      page.should have_selector('h2', text: 'Missing Link Music Client Portal')
      page.should have_link 'Sign in'
    end

    context "search function" do
      before { visit users_path }
      let(:user_string) { "#{user.last_name}, #{user.first_name}" }
      let(:other_user_string) { "#{other_user.last_name}, #{other_user.first_name}" }

      it "should be able to search for a user" do
        fill_in "Search name",       with:  "user.first"
        page.should have_content(user_string)
      end

      it "should go to a user's page upon search" do
        fill_in "Search name",       with: user_string
        click_button 'Go to user page'
        page.should have_selector('h2', text: user_string)
      end

      it "should go to another user's page upon re-search" do
        fill_in "Search name",       with: other_user_string
        click_button 'Go to user page'
        page.should have_selector('h2', text: other_user_string)
      end

      it "should render a flash if search returns nil" do
        fill_in "Search name",       with: "invalid, invalid"
        click_button 'Go to user page'
        page.should have_content("No users found")
      end
    end
  end
end
