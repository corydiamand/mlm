require 'csv'
namespace :db do
  desc "Fill database with fmp data"
  require do
    'lib/assets/users.csv'
    'lib/assets/claims.csv'
    'lib/assets/works.csv'
  end
  task populate: :environment do
    make_users
    #make_claims
    #make_works
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

def make_works
  CSV.foreach('lib/assets/works.csv', :headers => true) do |row|
    User.create!(row.to_hash)
  end
end