require 'spec_helper'

describe 'Users' do
	before do
		@user = User.new(first_name: "Example", email: "example@email.com", last_name: "User", password: "foobar") 
	end

	subject { @user }

	it { should respond_to(:id) }
	it { should respond_to(:first_name) }
	it { should respond_to(:last_name) }
	it { should respond_to(:email) }
	it { should respond_to(:encrypted_password) }

	describe "password validation" do

		describe "with blank password" do
			before do 
				@user.password = ' ' 
				@user.save
			end
			it { should_not be_valid }
		end
	end

	describe "password encryption" do
		before { @user.save! }
		after { @user.destroy }

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
		before { @user.save! }
		after { @user.destroy }

		it "should return the user" do
			user = User.find_by_email("example@email.com")
			user.should == @user
		end
	end
end