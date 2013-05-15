require 'csv'
namespace :db do
  desc "Fill database with fmp data"
  task populate: :environment do
    make_users
    make_claims
    make_works
  end
end

def make_users
  CSV.foreach('lib/assets/users.csv', :headers => true) do |row|
    user = User.new(row.to_hash)
    user.email = 'temp@email.com'
    user.save!(validate: false)
  end

end

def make_claims
  CSV.foreach('lib/assets/claims.csv', :headers => true) do |row|
    claim = WorkClaim.new(row.to_hash)
    claim.save!(validate: false)
  end
end

def make_works
  CSV.foreach('lib/assets/works.csv', :headers => true) do |row|
    work = Work.new(row.to_hash)
    work.save!(validate: false)
  end
end