# == Schema Information
#
# Table name: work_claims
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  work_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  mr_share   :float
#  web_id     :integer
#

require 'spec_helper'

describe WorkClaim do
  let(:user) { FactoryGirl.create(:user) }
  let(:work) { FactoryGirl.create(:work) }
  let!(:claim) { FactoryGirl.create(:work_claim, user: user, work: work, web_id: user.web_id) }

  subject { claim }

  it { should respond_to(:web_id) }
  it { should respond_to(:work_id) }
  it { should respond_to(:mr_share) }
  its(:user) { should be == user }
  its(:work) { should be == work }

  it { should be_valid }

  describe "Relationships" do

    it "should create a relationship" do
      user.works.should include work
    end
  end

  describe "Validations" do

    context "web id" do
      it "should not be valid when user_id is not present" do
        claim.web_id = nil 
        claim.should_not be_valid 
      end
    end

    context "work id" do
      it "should not be valid when work_id is not present" do
        claim.work_id  = nil 
        claim.should_not be_valid 
      end
    end

    context "mr_share" do
      it "should not be valid when mr_share is not present" do
        claim.mr_share = nil
        claim.should_not be_valid
      end

      it "should not be valid when mr_share is not within the right range" do
        claim.mr_share = 101
        claim.should_not be_valid
        claim.mr_share = 0
        claim.should_not be_valid
        claim.mr_share = 'invalid'
        claim.should_not be_valid
      end
    end
  end
end
