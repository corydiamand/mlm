#One time only test for prepopulated users!

require 'spec_helper'
require 'csv'

=begin
describe "User Accounts" do
  let(:users_hash) { {} }
  before do 
    CSV.foreach('spec/user_names.csv') do |row|
      users_hash[row[0]] = row[1]
    end
    visit root_path
  end
  
  it "should be established with temporary passwords" do
    users_hash.each do |k, v|
      fill_in "Email",    with: k
      fill_in "Password", with: v
      click_button "Sign in"
      page.should have_content("Successfully signed in!")
      visit root_path
    end
  end
end
=end