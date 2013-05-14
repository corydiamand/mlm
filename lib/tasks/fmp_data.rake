require 'csv'
namespace :db do
  desc "Fill database with fmp data"
  task populate: :environment do
    make_users
    make_claims
  end
end

def make_users
  CSV.foreach('lib/assets/users.csv', :headers => true) do |row|
    User.create!(row.to_hash)
  end
end

def make_claims
  CSV.foreach('lib/assets/claims.csv', :headers => true) do |row|
    User.create!(row.to_hash)
  end
end