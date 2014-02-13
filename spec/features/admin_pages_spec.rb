require 'spec_helper'

describe 'Admin Pages' do
  let!(:user) { FactoryGirl.create(:user) }
  let!(:statement) { FactoryGirl.create(:statement, user_id: user.id) }
  let!(:other_statement) { FactoryGirl.create(:statement, user_id: other_user.id) }
  let(:other_user) { FactoryGirl.create(:user) }
  let(:admin) { FactoryGirl.create(:admin) }
  let(:work) { FactoryGirl.create(:work) }
  let!(:claim) { FactoryGirl.create(:work_claim, user: user, work: work) }

  before do
    sign_in_through_ui user
    visit edit_user_path user
    fill_in "Password",              with: user.password
    fill_in "Confirm password",      with: user.password
    click_button "Save changes"
    user.reload.should be_pending
    visit edit_user_work_path(user, work)
    click_button "Update work"
    work.reload.should be_pending
    click_link "Sign out"
    sign_in_through_ui admin
  end

  context "Layout" do

    it "should render the sidebar and flash" do
      page.should have_content('Successfully signed in!')
      page.should have_content "Pending Users"
      page.should have_content "Pending Works"
      page.should have_content "User Index"
      page.should have_content "My Admin Account"
      page.should_not have_content "View User Catalog"
    end

    it "should render the notifications on each page" do
      visit admin_users_pending_path
      page.should have_css(".badge-important", text: "1")
      visit admin_works_pending_path
      page.should have_css(".badge-important", text: "1")
      visit admin_users_path
      page.should have_css(".badge-important", text: "1")
      visit admin_user_statements_path(user)
      page.should have_css(".badge-important", text: "1")
      visit admin_user_works_path(user)
      page.should have_css(".badge-important", text: "1")
    end
  end

  context "Users pending" do
    before { visit admin_users_pending_path }

    it "should render the form" do
      page.should have_content "Pending user updates"
    end

    it "should list pending users" do
      page.should have_content user.first_name
    end

    it "should update the pending status of the user" do
      page.find(:css, "#pending_#{user.id}").set(true)
      click_button "Update pending users"
      page.should have_content('User status updated')
      user.reload.should_not be_pending
      page.should_not have_css(".badge-important", text: "0")
    end


    it "should render the page if no users are selected" do
      click_button "Update pending users"
      page.should have_content('No users selected')
    end
  end

  context "Works pending" do
    before { visit admin_works_pending_path }

    it "should render the form" do
      page.should have_content "Pending work updates"
    end

    it "should list pending users" do
      page.should have_content work.title
    end

    it "should update the pending status of the work" do
      page.find(:css, "#pending_#{work.id}").set(true)
      click_button "Update pending works"
      page.should have_content('Work status updated')
      work.reload.should_not be_pending
    end

    it "should render the page if no works are selected" do
      click_button "Update pending works"
      page.should have_content('No works selected')
    end
  end

  context "User statements" do
    before { visit admin_user_statements_path(user) }

    it "should be able to see a user's statements" do
      page.should have_selector('h2', user.first_name)
      page.should have_selector('div', statement.id)
    end

    it "should update the sidebar" do
      page.should have_content "View User Catalog"
    end

    it "should have delete buttons for statements and users" do
      page.should have_css(".delete-content .button_to")
      first(".statements-body .delete-content input").click
    end

  end

  context "User works" do
    before { visit admin_work_path(work) }

    it "should display the mr share" do
      page.should have_selector('div', text: "#{claim.mr_share}")
    end
    it "should have a delete button" do
      page.should have_css(".delete-work-button")
    end

  end



  describe "User Index" do

    context "Search function" do
      before { visit admin_users_path }
      let(:user_string) { "#{user.last_name}, #{user.first_name}" }
      let(:other_user_string) { "#{other_user.last_name}, #{other_user.first_name}" }

      it "should be able to search for a user" do
        fill_in "Search name",       with:  "user.first"
        page.should have_content(user_string)
      end

      it "should go to a user's page upon search" do
        fill_in "Search name",       with: user_string
        click_button 'View user statements'
        page.should have_selector('h2', text: user_string)
      end

      it "should go to another user's page upon re-search" do
        fill_in "Search name",       with: other_user_string
        click_button 'View user statements'
        page.should have_selector('h2', text: other_user_string)
      end

      it "should render a flash if search returns nil" do
        fill_in "Search name",       with: "invalid, invalid"
        click_button 'View user statements'
        page.should have_content("No users found")
      end
    end
  end

  describe "All Statements" do
    before { visit admin_allstatements_path}

    it "should have a list of statements, atleast one, but less than 50" do
      page.should have_content statement.date.strftime('%b %d')
      if (Statement.count <= 50)
        page.should have_css(".statement-record", :minimum => Statement.count)
        page.should have_css(".statement-record", :maximum => 50)
      else  
        page.should have_css(".statement-record", :minimum => 1)
        page.should have_css(".statement-record", :maximum => 50)
      end
    end

    it "should have statements joined with user" do
      page.should have_content statement.user.first_name
    end

    it "should have a delete button" do
      page.should have_css(".delete-content .button_to")
      first_count = Statement.count
      first(".delete-content input").click
    end
  end

  describe "Sign-in Log" do
    before { visit admin_sessions_path}

    it "should have a list of sessions, atleast one, but less than 50" do
      page.should have_css(".login-content")
      page.should have_css(".logout-content")
      page.should have_css(".length-content")
      page.should have_css(".user-content")

      page.should have_content("14'") #better changes this to 15' next year :p

      if (Statement.count <= 50)
        page.should have_css(".session-record", :minimum => Statement.count)
        page.should have_css(".session-record", :maximum => 50)
      else  
        page.should have_css(".session-record", :minimum => 1)
        page.should have_css(".session-record", :maximum => 50)
      end

    end

    it "should have sessions joined with user" do
      page.should have_content statement.user.first_name
    end
  end

  context "Update Portal" do
    before { visit admin_portal_updates_path(work) }
    it "should have an update button" do
      page.should have_css("form.button_to")
    end
  end

  context "View work" do
    before { visit admin_work_path(work) }

    it "should display the work detail" do
      page.should have_content work.title
      page.should have_content user.last_name
    end

    it "should be pending" do
      page.should have_content "This work is pending"
    end
  end

  context "Edit self" do
    before { visit edit_user_path admin }

    it "admin should not be pending upon edit" do
      page.fill_in "Password",                with: admin.password
      page.fill_in "Confirm password",        with: admin.password
      click_button "Save changes"
      admin.reload.should_not be_pending
    end 
  end
end
