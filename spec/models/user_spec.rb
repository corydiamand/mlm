require 'spec_helper'

describe 'Users' do
	before do
		@user = User.new(id: 400, first_name: "Example", last_name: "User", password: "foobar") 
	end

	subject { @user }

	it { should respond_to(:id) }
	it { should respond_to(:first_name) }
	it { should respond_to(:last_name) }
	it { should respond_to(:password) }

	describe "it should encrypt the user's password" do
		before { @user.encrypt_password }
		
		its(:password) { should_not be("foobar") }
	end
end