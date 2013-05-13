# == Schema Information
#
# Table name: works
#
#  id               :integer          not null, primary key
#  audio_product_id :integer
#  title            :string(255)
#  duration         :string(255)
#  copyright_date   :string(255)
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#

require 'spec_helper'

describe Work do

  let(:work) { FactoryGirl.create(:work) }

  subject { work }

  it { should respond_to(:audio_product_id) }
  it { should respond_to(:title) }
  it { should respond_to(:duration) }
  it { should respond_to(:copyright_date) }

  it { should be_valid }

end
