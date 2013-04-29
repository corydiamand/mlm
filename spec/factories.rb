FactoryGirl.define do
	factory :user do
		sequence(:first_name) 	{ |n| "First #{n}" }
		sequence(:last_name) 	{ |n| "Last #{n}" }
		sequence(:email)	{ |n| "person_#{n}@example.com" }
		password 			"foobar"

		factory :admin do
			admin 1
		end
	end

  factory :statement do
    quarter 'Q2'
    year 2013
    amount 1000
    filename 'Test.xls'
  end
end