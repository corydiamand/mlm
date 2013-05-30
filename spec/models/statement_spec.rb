# == Schema Information
#
# Table name: statements
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  quarter    :string(255)
#  year       :string(255)
#  amount     :integer
#  filename   :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'spec_helper'

describe 'Statements' do

  let(:user) { FactoryGirl.create(:user) }
  let(:statement) { FactoryGirl.create(:statement, user: user) }

  subject { statement }

  it { should respond_to(:user_id) }
  it { should respond_to(:quarter) }
  it { should respond_to(:year) }
  it { should respond_to(:amount) }
  it { should respond_to(:filename) }
  its(:user) { should == user }

  it { should be_valid }

  describe "Validations" do

    context "user id" do

      it "should not be valid when user_id is not present" do
        statement.user_id = nil 
        statement.should_not be_valid 
      end
    end

    context "filename" do

      it "should not be valid when filename is not present" do
        statement.filename = nil
        statement.should_not be_valid
      end

      it "should not be valid when filename is blank" do
        statement.filename = ' '
        statement.should_not be_valid
      end
    end

    context "quarter" do

      it "should not be valid when quarter is not present" do
        statement.quarter = nil
        statement.should_not be_valid
      end
    end

    context "year" do

      it "should not be valid when year is not present" do
        statement.year = nil
        statement.should_not be_valid
      end
    end

    context "amount" do

      it "should not be valid when amount is not present" do
        statement.amount = nil
        statement.should_not be_valid
      end
    end
  end

end
