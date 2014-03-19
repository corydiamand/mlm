# == Schema Information
#
# Table name: statements
#
#  id         :integer          not null, primary key
#  quarter    :string(255)
#  year       :string(255)
#  amount     :float
#  filename   :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  date       :date
#  web_id     :integer
#  user_id    :integer
#

require 'spec_helper'

describe 'Statements' do

  let(:user) { FactoryGirl.create(:user) }
  let(:statement) { FactoryGirl.create(:statement, web_id: user.web_id) }

  subject { statement }

  #it { should respond_to(:user_id) }
  it { should respond_to(:quarter) }
  it { should respond_to(:year) }
  it { should respond_to(:amount) }
  it { should respond_to(:filename) }
  it { should respond_to(:date) }
  it { should respond_to(:date_string) }
  it { should respond_to(:web_id) }
  its(:user) { should == user }

  it { should be_valid }

  describe "Validations" do

=begin
    context "user id" do

      it "should not be valid when user_id is not present" do
        statement.user_id = nil 
        statement.should_not be_valid 
      end
    end

=end 
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

    context "date_string" do
      it "should not be valid when amount is not present" do
        statement.date_string = nil
        statement.should_not be_valid
      end
    end
  end

  describe "Callbacks" do
    before { statement.update_attributes(date_string: '9/27/2013') }

    it "should convert the statement date string to a date" do
      statement.date.should_not be nil
      statement.reload.date.class.should be Date
    end
  end

  describe "Associations" do

    context "User" do
      let!(:older_statement) { FactoryGirl.create(:statement, user: user, web_id: 1, date_string: '06/01/1999') }
      let!(:newer_statement) { FactoryGirl.create(:statement, user: user, web_id: 1, date_string: '01/01/2000') }

      it "should display the statements in the right order" do
        user.statements.should == [newer_statement, older_statement]
      end
    end
  end
end
