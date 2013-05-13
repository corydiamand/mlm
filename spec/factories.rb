FactoryGirl.define do
	factory :user do
		sequence(:first_name) 	{ |n| "First #{n}" }
		sequence(:last_name) 	{ |n| "Last #{n}" }
		sequence(:email)	{ |n| "person_#{n}@example.com" }
		password 			          "foobar"
    password_confirmation   "foobar"

		factory :admin do
			admin true
		end
	end

  factory :statement do
    quarter 'Q2'
    year '2013'
    sequence(:amount) { |n| "100#{n}" }
    filename 'Test.pdf'
    user
  end

  factory :work do
    sequence(:work_title)  { |n| "Work #{n}" }
    duration '03:00'
    copyright_date '09/27/1990'
  end

  factory :work_claim do
    user
    work
    mr_share 25
  end
end