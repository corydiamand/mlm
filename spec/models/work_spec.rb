# == Schema Information
#
# Table name: works
#
#  id             :integer          not null, primary key
#  title          :string(255)
#  duration       :string(255)
#  copyright_date :string(255)
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#

require 'spec_helper'

describe Work do

  let(:work) { FactoryGirl.create(:work) }

  subject { work }

  it { should respond_to(:title) }
  it { should respond_to(:duration) }
  it { should respond_to(:copyright_date) }
  it { should respond_to(:copyright_date_string)}
  
  it { should be_valid }

  context "Callbacks" do

    it "should upcase the work title" do
      work.title = 'lowercase'
      work.save
      work.title.should be == 'LOWERCASE'
    end

    it "should convert the copyright date string to a date" do
      work.update_attributes!(copyright_date_string: '9/27/2013')
      work.copyright_date.should_not be nil
      work.reload.copyright_date.class.should be Date
    end
  end
end
