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

  factory :portal_update do
    date Time.now
    user
  end

  factory :session do
    login Time.now
    logout Time.now + (60*10) #10 minute long session
    user_id 1
  end

  factory :statement do
    quarter 'Q2'
    year '2013'
    sequence(:amount) { |n| "100#{n}" }
    filename 'Test.pdf'
    user
    date_string '01/01/2000' 
  end

  factory :work do
    sequence(:title)  { |n| "Work #{n}" }
    duration '03:00'
    copyright_date_string '09/27/1990'
  end

  factory :work_claim do
    user
    work
    sequence(:mr_share) { |n| "#{n}.5" }
  end

  factory :audio_product do
    work
    artist 'Theo and the Test Specs'
    album 'Greatest Specs'
    label 'Missing Link Music'
    sequence(:catalog_number) { |n| "000#{n}" }
  end
end