require 'spec_helper'

describe 'Works Pages' do
  let!(:user) { FactoryGirl.create(:user) }
  let(:work) { FactoryGirl.create(:work) }
  let!(:claim) { FactoryGirl.create(:work_claim, user: user, work: work) }

  before do 
    sign_in_through_ui user
    visit user_works_path user
  end 

  it "should display the user's works" do
    page.should have_content(work.title)
  end

end
