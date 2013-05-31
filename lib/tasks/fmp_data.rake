require 'csv'
namespace :db do
  desc "Fill database with fmp data"
  task populate: :environment do
    name_columns
    make_users
    make_claims
    make_works
    make_audio_products
    make_statements
  end
end

def name_columns

  filenames = { 'users.csv' => "\"first_name\",\"last_name\"", 
            'claims.csv'=> "\"user_id\",\"work_id\",\"mr_share\"" ,
            'works.csv'=> "\"title\",\"duration\",\"copyright_date\"" ,
            'audio_products.csv' => "\"work_id\",\"artist\",\"album\",\"label\",\"catalog_number\"" ,
            'statements.csv' => "\"user_id\",\"quarter\",\"year\",\"amount\",\"filename\",\"date\"" }


  filenames.each do |path, columns|
    path_to_file = "lib/assets/#{path}"
    current_file = File.open(path_to_file, 'r')
    text = current_file.read
    current_file.close
    current_file = File.open(path_to_file, 'w')
    current_file.write("#{columns}\r\n#{text}")
    current_file.close
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

def make_audio_products
  CSV.foreach('lib/assets/audio_products.csv', :headers => true) do |row|
    audio_product = AudioProduct.new(row.to_hash)
    audio_product.save!(validate: false)
  end
end

def make_statements
  CSV.foreach('lib/assets/statements.csv', :headers => true) do |row|
    statement = Statement.new(row.to_hash)
    statement.save!(validate: false)
  end
end

