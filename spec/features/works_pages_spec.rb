require 'spec_helper'

describe 'Works Pages' do
  let!(:user) { FactoryGirl.create(:user) }
  let(:admin) { FactoryGirl.create(:admin) }
  let(:work) { FactoryGirl.create(:work) }
  let(:other_work) { FactoryGirl.create(:work) }
  let!(:claim) { FactoryGirl.create(:work_claim, user: user, work: work) }
  let!(:other_claim) { FactoryGirl.create(:work_claim, user: user, work: other_work) }
  let!(:audio_product) { FactoryGirl.create(:audio_product, work: work) }

  context "as a user" do 

    before do 
      sign_in_through_ui user
      visit user_works_path user
    end

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

  context "as an admin" do

    before do 
      sign_in_through_ui admin
      visit user_works_path user
    end

    it "should display the mr share" do
      page.should have_selector('div', text: "#{claim.mr_share}")
    end
  end
end
