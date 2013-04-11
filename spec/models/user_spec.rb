require 'spec_helper'

describe 'Users' do
	before do
		@user = User.new(id: 400, first_name: "Example", last_name: "User") 
	end

	subject { @user }

	it { should respond_to(:id) }
	it { should respond_to(:first_name) }
	it { should respond_to(:last_name) }
end