require 'spec_helper'

describe 'Users' do
  
  before(:all) do 
    @user = FactoryGirl.create(:user)
    @admin = FactoryGirl.create(:admin)
    remove_portals(@user)
  end

  after(:all) do
    @user.destroy
    @admin.destroy
  end

  subject { @user }

  it { should respond_to(:id) }
  it { should respond_to(:first_name) }
  it { should respond_to(:last_name) }
  it { should respond_to(:email) }
  it { should respond_to(:encrypted_password) }
  it { should respond_to(:remember_token) }
  it { should respond_to(:password_reset_token) }
  it { should respond_to(:password_reset_sent_at) }
  it { should respond_to(:statements) }

  describe "Validations" do

    context "Password" do

      it "should not be valid when password is blank" do
        @user.password = ' '
        @user.should_not be_valid
      end

      it "should not be valid when password is too short" do
        @user.password = 'a' * 5
        @user.should_not be_valid
      end

      it "should be valid with valid password" do
        @user.password = 'foobar'
        @user.should be_valid
      end
    end
  end

  describe "Callbacks" do

    context "password encryption" do

      it "should set the encrypted password" do
        @user.encrypted_password.should_not be_blank
      end
    end

    context "remember_token" do

      it "should set a remember token" do
        @user.remember_token.should_not be_blank
      end
    end
  end

  describe "Methods" do

    context "has_password?" do

      it "should be true if passwords match" do
        @user.has_password?(@user.password).should be_true
      end

      it "should be false if passwords don't match" do
        @user.has_password?("invalid").should be_false
      end
    end

    context "authenticate" do

      it "should return nil on email/password mismatch" do
        wrong_password_user = User.authenticate(@user.email, "wrongpass")
        wrong_password_user.should be_nil
      end

      it "should return nil for an email with no user" do
        nonexistent_user = User.authenticate("wrong@email.com", @user.password)
        nonexistent_user.should be_nil
      end

      it "should return the user on email/password match" do
        matching_user = User.authenticate(@user.email, @user.password)
        matching_user.should == @user
      end
    end

    context "find_by_email" do

      it "should return nil on email mismatch" do
        user = User.find_by_email("invalid@invalid.inv")
        user.should be_nil
      end

      it "should return the user if email matches" do
        user = User.find_by_email(@user.email)
        user.should == @user
      end
    end

    context "send_password_reset" do

      it "should generate a unique password_reset_token each time" do
        @user.send_password_reset
        last_token = @user.password_reset_token
        @user.send_password_reset
        @user.password_reset_token.should_not == last_token
      end

      it "should save the time the password reset was sent" do
        @user.send_password_reset
        @user.reload.password_reset_sent_at.should be_present
      end

      it "should deliver an email to the user" do
        @user.send_password_reset
        last_email.to.should include(@user.email)
      end
    end
  end

  describe "Attributes" do

    context "admin" do

      it "should not be an admin by default" do
        @user.should_not be_admin
      end

      it "admin should be admin" do
        @admin.should be_admin
      end
    end
  end
end