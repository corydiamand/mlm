require 'spec_helper'

describe 'Users' do
	
	before(:all) { @user = FactoryGirl.create(:user) }
	after(:all) { @user.destroy}

	subject { @user }

	it { should respond_to(:id) }
	it { should respond_to(:first_name) }
	it { should respond_to(:last_name) }
	it { should respond_to(:email) }
	it { should respond_to(:encrypted_password) }
	it { should respond_to(:remember_token) }

	describe "password validation" do

		describe "with blank password" do
			before do
				 @wronguser = FactoryGirl.create(:user) 
				 @wronguser.password = ' ' 
			end
			after { @wronguser.destroy }

			subject { @wronguser }

			it { should_not be_valid }
		end
	end

	describe "after being saved to the db" do

		describe "password encryption" do

			it "should set the encrypted password" do
				@user.encrypted_password.should_not be_blank
			end

			describe "has_password? method" do

				it "should be true if passwords match" do
					@user.has_password?(@user.password).should be_true
				end

				it "should be false if the passwords don't match" do
					@user.has_password?("invalid").should be_false
				end
			end

			describe "authenticate method" do

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
		end

		describe "find_by_email method" do

			it "should return the user" do
				user = User.find_by_email("example@email.com")
				user.should == @user
			end
		end
	end
end