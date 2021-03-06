require 'spec_helper'

describe 'Works Pages' do
  let!(:user) { FactoryGirl.create(:user) }
  let(:admin) { FactoryGirl.create(:admin) }
  let(:work) { FactoryGirl.create(:work) }
  let(:other_work) { FactoryGirl.create(:work) }
  let!(:claim) { FactoryGirl.create(:work_claim, web_id: user.web_id, user: user, work: work) }
  let!(:other_claim) { FactoryGirl.create(:work_claim, web_id: user.web_id, user: user, work: other_work) }
  let!(:audio_product) { FactoryGirl.create(:audio_product, work: work) }

  describe "as a user" do 

    before { sign_in_through_ui user }
    let(:share_id) { "work_work_claims_attributes_0_mr_share" }

    context "index action" do

      before { visit user_works_path user }

      it "should display the user's works" do
        page.should have_selector('a', work.title)
        page.should have_selector('a', other_work.title)
      end

      it "should display the work's audio product" do
        page.should have_selector('div', text: audio_product.album)
        page.should have_selector('div', text: audio_product.artist)
        page.should have_selector('div', text: audio_product.label)
        page.should have_selector('div', text: audio_product.catalog_number)
      end

      it "should display the mr share" do
        page.should have_selector('div', text: "#{claim.mr_share}")
        page.find(:xpath, "//div[@class='mr-share' and contains(., '#{claim.mr_share}')]")
      end

      it "should link to the edit page" do
        page.find(:xpath, "//a[@href = '#{edit_user_work_path(user, work)}']")
      end
    end

    context "new action" do

      before do 
        visit new_user_work_path user
        other_work.destroy  #This is to avoid duplication of a work with no audio product
      end
      let(:no_audio_product) { "No audio product information available" }

      it "should render the forms" do
        page.should have_selector('h2', "Submit new work")
      end

      it "should create a new work with valid information", js: true do
        page.fill_in "Title",           with: 'NEW WORK'
        page.fill_in share_id,      with: '99'
        page.click_link "Add Audio Product"
        page.fill_in "Album",           with: 'NEW ALBUM'
        page.should have_content 'Audio product 1'
        click_button 'Submit new work'
        page.should have_content "Successfully submitted work"
        page.should have_content 'NEW WORK'
        page.find(:xpath, "//div[@class='mr-share' and contains(., '99.0')]")
        page.find(:xpath, "//div[@class='audio-product' and contains(., 'NEW ALBUM')]")
      end

      it "should not create a work without mr-share" do
        page.fill_in "Title",  with: 'INVALID WORK'
        click_button 'Submit new work'
        page.should have_content "Your share can't be blank"
      end

      it "should not create a work without mr-share and display the correct errors" do
        page.fill_in "Title",  with: 'INVALID WORK'
        page.fill_in share_id, with: 101
        click_button 'Submit new work'
        page.should have_content 'Your share must be less than or equal to 100'
        page.fill_in share_id, with: 0
        click_button 'Submit new work'
        page.should have_content 'Your share must be greater than 0'
        page.fill_in share_id, with: 'invalid'
        click_button 'Submit new work'
        page.should have_content 'Your share is not a number'
      end

      it "should not create an audio product if not specified", js: true do
        page.fill_in "Title",   with: 'No Audio Product'
        page.fill_in share_id,  with: '99'
        page.click_link "Add Audio Product"
        click_button "Submit new work"
        page.should have_content "Successfully submitted work"
        page.find(:xpath, "//div[@class='no-works-found']")
      end
    end

    context "edit action" do
      before { visit edit_user_work_path(user, work) }

      it "should render the forms" do
        page.should have_selector('h2', "Edit work")
        page.should have_button "Update work"
      end

      it "should update a work with valid information" do
        page.fill_in "Title",           with: 'UPDATED TITLE'
        page.fill_in share_id,          with: '25'
        click_button "Update work"
        page.should have_content "Work updated"
        page.should have_content "UPDATED TITLE"
      end

      it "should not create a work with invalid information" do
        page.fill_in "Title",      with:  ""
        page.fill_in share_id,     with:  ""
        click_button "Update work"
        page.should have_content "Title can't be blank"
        page.should have_content "Your share can't be blank"
      end
    end
  end
end
