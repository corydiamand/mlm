require 'spec_helper'

describe 'Works Pages' do
  let!(:user) { FactoryGirl.create(:user) }
  let(:admin) { FactoryGirl.create(:admin) }
  let(:work) { FactoryGirl.create(:work) }
  let(:other_work) { FactoryGirl.create(:work) }
  let!(:claim) { FactoryGirl.create(:work_claim, user: user, work: work) }
  let!(:other_claim) { FactoryGirl.create(:work_claim, user: user, work: other_work) }
  let!(:audio_product) { FactoryGirl.create(:audio_product, work: work) }

  describe "as a user" do 

    before { sign_in_through_ui user }

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
    end

    context "new action" do

      before { visit new_user_work_path user }

      it "should render the forms" do
        page.should have_selector('h2', "Submit new work")
      end

      it "should render the audio product form" do
        page.should have_link("Add Audio Product")
      end
    end

  end

  describe "as an admin" do

    before do 
      sign_in_through_ui admin
      visit user_works_path user
    end

    it "should display the mr share" do
      page.should have_selector('div', text: "#{claim.mr_share}")
    end
  end
end
