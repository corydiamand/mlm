require 'spec_helper'

describe 'Works Pages' do
  let!(:user) { FactoryGirl.create(:user) }
  let(:work) { FactoryGirl.create(:work) }
  let(:other_work) { FactoryGirl.create(:work) }
  let!(:claim) { FactoryGirl.create(:work_claim, user: user, work: work) }
  let!(:other_claim) { FactoryGirl.create(:work_claim, user: user, work: other_work) }

  before do 
    sign_in_through_ui user
    visit user_works_path user
  end 

  it "should display the user's works" do
    page.should have_content(work.title)
    page.should have_content(other_work.title)
  end

end
