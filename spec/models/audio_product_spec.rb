# == Schema Information
#
# Table name: audio_products
#
#  id             :integer          not null, primary key
#  work_id        :integer
#  artist         :string(255)
#  album          :string(255)
#  label          :string(255)
#  catalog_number :string(255)
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#
# Indexes
#
#  index_audio_products_on_work_id  (work_id)
#

require 'spec_helper'

describe AudioProduct do
  let(:work) { FactoryGirl.create(:work) }
  let(:audio_product) { FactoryGirl.create(:audio_product, work: work) }

  subject { audio_product }
  it { should respond_to(:work_id) }
  it { should respond_to(:artist) }
  it { should respond_to(:album) }
  it { should respond_to(:label) }
  it { should respond_to(:catalog_number) }
  its(:work) { should be == work }

  it { should be_valid }

  context "Validations" do

    it "should be invalid if work_id is nil" do
      audio_product.work_id = nil
      audio_product.should_not be_valid
    end
  end

  context "Callbacks" do

    it "should upcase the audio product details" do
      audio_product.update_attributes(artist: 'lowercase', album: 'lowercase', 
                                      label: 'lowercase')
      audio_product.label.should == 'LOWERCASE'
      audio_product.album.should == 'LOWERCASE'
      audio_product.artist.should == 'LOWERCASE'
    end
  end
end
