# == Schema Information
#
# Table name: work_claims
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  work_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  mr_share   :integer
#

require 'spec_helper'

describe WorkClaim do
  let(:user) { FactoryGirl.create(:user) }
  let(:work) { FactoryGirl.create(:work) }
  let!(:claim) { FactoryGirl.create(:work_claim, user: user, work: work) }

  subject { claim }

  it { should respond_to(:user_id) }
  it { should respond_to(:work_id) }
  it { should respond_to(:mr_share) }
  its(:user) { should be == user }
  its(:work) { should be == work }

  it { should be_valid }

  context "accessible attributes" do

    it "should not allow access to user_id" do
      expect do
        WorkClaim.new(user_id: user.id)
      end.to raise_error(ActiveModel::MassAssignmentSecurity::Error)
    end

    it "should not allow access to work_id" do
      expect do
        WorkClaim.new(work_id: work.id)
      end.to raise_error(ActiveModel::MassAssignmentSecurity::Error)
    end
  end

  describe "Relationships" do

    it "should create a relationship" do
      user.works.should include work
    end
  end

  describe "Validations" do

    context "user id" do

      it "should not be valid when user_id is not present" do
        claim.user_id = nil 
        claim.should_not be_valid 
      end
    end

    context "work id" do
      it "should not be valid when work_id is not present" do
        claim.work_id  = nil 
        claim.should_not be_valid 
      end
    end
  end
end
