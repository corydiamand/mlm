require 'spec_helper'

describe 'User Pages' do
	before do
		@user = User.new(first_name: "Example", last_name: "User", email: "example@email.com", password: "foobar") 
	end

	subject { page }
end

