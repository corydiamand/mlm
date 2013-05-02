# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  first_name             :string(255)
#  last_name              :string(255)
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  email                  :string(255)
#  admin                  :boolean
#  encrypted_password     :string(255)
#  salt                   :string(255)
#  remember_token         :string(255)
#  area_code              :string(255)
#  phone_number           :string(255)
#  apartment_number       :string(255)
#  address_number         :string(255)
#  street_name            :string(255)
#  city                   :string(255)
#  state                  :string(255)
#  zip_code               :string(255)
#  password_reset_token   :string(255)
#  password_reset_sent_at :datetime
#

require 'digest'
class User < ActiveRecord::Base
  attr_accessible :first_name, :last_name, :email, :area_code, :phone_number,
                  :apartment_number, :address_number, :street_name, :city,
                  :state, :zip_code
	validates :password, presence: true,
						           confirmation: true,
						           length: { minimum: 6 }
	before_save do 
		generate_token(:remember_token) 
		encrypt_password
	end

	# Return true if the user's password matches the submitted password.
	def has_password?(submitted_password)
		encrypted_password == encrypt(submitted_password)
	end

	def self.authenticate(submitted_email, submitted_password)
		user = User.find_by_email(submitted_email)
		return nil if user.nil?
		return user if user.has_password?(submitted_password)
	end

	def self.authenticate_with_salt(id, cookie_salt)
		user = User.find_by_id(id)
		(user && user.salt == cookie_salt) ? user : nil
	end

	def send_password_reset
		generate_token(:password_reset_token)
		self.password_reset_sent_at = Time.zone.now
    self.password = self.encrypted_password
		save!
		UserMailer.password_reset(self).deliver
	end

  def statements
    return self.portals[:statements]
  end

	private

    def encrypt_password
      self.salt = make_salt unless has_password?(password)
      self.encrypted_password = encrypt(password)
    end

    def encrypt(string)
      secure_hash("#{salt}--#{string}")
    end

    def make_salt
      secure_hash("#{Time.now.utc}--#{password}")
    end

    def secure_hash(string)
      Digest::SHA512.hexdigest(string)
    end

    def generate_token(column)
    	self[column] = SecureRandom.urlsafe_base64
    end

end
