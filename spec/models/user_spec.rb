# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  first_name             :string(255)
#  last_name              :string(255)
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  email                  :string(255)
#  admin                  :boolean
#  encrypted_password     :string(255)
#  salt                   :string(255)
#  remember_token         :string(255)
#  area_code              :string(255)
#  phone_number           :string(255)
#  apartment_number       :string(255)
#  address_number         :string(255)
#  street_name            :string(255)
#  city                   :string(255)
#  state                  :string(255)
#  zip_code               :string(255)
#  password_reset_token   :string(255)
#  password_reset_sent_at :datetime
#  password_digest        :string(255)
#  fmp_user_id            :integer
#

require 'spec_helper'

describe 'Users' do
  
  let(:user) { FactoryGirl.create(:user) }
  let(:admin) { FactoryGirl.create(:admin) }

  subject { user }

  it { should respond_to(:id) }
  it { should respond_to(:first_name) }
  it { should respond_to(:last_name) }
  it { should respond_to(:email) }
  it { should respond_to(:password) }
  it { should respond_to(:password_digest) }
  it { should respond_to(:remember_token) }
  it { should respond_to(:password_reset_token) }
  it { should respond_to(:password_reset_sent_at) }

  it { should be_valid }

  describe "Validations" do

    context "Password" do

      it "should not be valid when password is blank" do
        user.password = ' '
        user.should_not be_valid
      end

      it "should not be valid when password is too short" do
        user.password = 'a' * 5
        user.should_not be_valid
      end

      it "should be valid with valid password" do
        user.password = 'foobar'
        user.should be_valid
      end
    end

    context "Email" do

      it "should not be valid when email is blank" do
        user.email = ' '
        user.should_not be_valid
      end
      it "should be invalid when format is invalid" do
        addresses = %w[user@foo,com user_at_foo.org example.user@foo.
                       foo@bar_baz.com foo@bar+baz.com]
        addresses.each do |invalid_address|
          user.email = invalid_address
          user.should_not be_valid
        end      
      end
    end
  end

  describe "Callbacks" do

    context "password encryption" do

      it "should set the encrypted password" do
        user.password_digest.should_not be_blank
      end
    end

    context "remember_token" do

      it "should set a remember token" do
        user.remember_token.should_not be_blank
      end
    end

    context "formatting" do
      before do
        user.update_attributes(first_name: 'lowercase',
                               last_name:  'lowercase',
                               email:      'UPPER@CASE.COM')
      end

      it "should upcase the user's first name" do
        user.reload.first_name.should == 'LOWERCASE'
      end

      it "should upcase the user's last name" do
        user.reload.last_name.should == 'LOWERCASE'
      end

      it "should downcase the user's email address" do
        user.reload.email.should == 'upper@case.com'
      end
    end
  end

  describe "Methods" do

    context "authenticate" do
      before { user.save }
      let(:found_user) { User.find_by_email(user.email) }
      let(:user_for_invalid_password) { found_user.authenticate("invalid") }

      it "should return the user with valid password" do
        user.should == found_user.authenticate(user.password)
      end

      it "should not return the user with invalid password" do
        user.should_not == user_for_invalid_password
        user_for_invalid_password.should be_false
      end
    end

    context "send_password_reset" do

      it "should generate a unique password_reset_token each time" do
        user.send_password_reset
        last_token = user.password_reset_token
        user.send_password_reset
        user.password_reset_token.should_not == last_token
      end

      it "should save the time the password reset was sent" do
        user.send_password_reset
        user.reload.password_reset_sent_at.should be_present
      end

      it "should deliver an email to the user" do
        user.send_password_reset
        last_email.to.should include(user.email)
      end
    end
  end

  describe "Attributes" do

    context "admin" do

      it "should not be an admin by default" do
        user.should_not be_admin
      end

      it "admin should be admin" do
        admin.should be_admin
      end

      it "should not be convertable to an admin" do
        expect do
          User.new(admin: true)
        end.to raise_error(ActiveModel::MassAssignmentSecurity::Error)
      end

      it "should toggle to an admin" do
        user.save!
        user.toggle(:admin)
        user.should be_admin 
      end
    end
  end
end
