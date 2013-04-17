FactoryGirl.define do
	factory :user do
		first_name			"Example"
		last_name			"User"
		email				"example@email.com"
		password 			"foobar"
	end
end