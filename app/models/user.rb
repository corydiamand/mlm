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
#  password_digest        :string(255)
#

require 'digest'
class User < ActiveRecord::Base
  has_secure_password
  attr_accessible :first_name, :last_name, :email, :area_code, :phone_number,
                  :apartment_number, :address_number, :street_name, :city,
                  :state, :zip_code, :password, :password_confirmation
	validates :password, length: { minimum: 6 }
  validates :password_confirmation, presence: true
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence:   true,
                    format:     { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }

	before_save { generate_token(:remember_token) }
  before_save { email.downcase! }
  before_save { first_name.upcase! }
  before_save { last_name.upcase! }

	def send_password_reset
		generate_token(:password_reset_token)
		self.password_reset_sent_at = Time.zone.now
    save!(validate: false)
		UserMailer.password_reset(self).deliver
	end

	private

    def generate_token(column)
    	self[column] = SecureRandom.urlsafe_base64
    end

end
