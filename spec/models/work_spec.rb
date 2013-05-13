# == Schema Information
#
# Table name: works
#
#  id               :integer          not null, primary key
#  user_id          :integer
#  audio_product_id :integer
#  work_title       :string(255)
#  duration         :string(255)
#  copyright_date   :string(255)
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#

require 'spec_helper'

describe Work do
  
  let(:user) { FactoryGirl.create(:user) }
  let(:work) { FactoryGirl.create(:work, user: user) }

  subject { work }

  it { should respond_to(:user_id) }
  it { should respond_to(:audio_product_id) }
  it { should respond_to(:work_title) }
  it { should respond_to(:duration) }
  it { should respond_to(:copyright_date) }
  its(:user) { should == user }

  it { should be_valid }

  context "accessible attributes" do
    it "should not allow access to user_id" do
      expect do
        Work.new(user_id: user.id)
      end.to raise_error(ActiveModel::MassAssignmentSecurity::Error)
    end
  end

  describe "Validations" do

    context "user id" do

      it "should not be valid when user_id is not present" do
        work.user_id = nil 
        work.should_not be_valid 
      end
    end
  end
end
