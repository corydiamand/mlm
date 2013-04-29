require 'digest'
require 'rfm'
class User < Rfm::Base
	config :layout => 'Users'
	attr_accessor :password
	validates :password, presence: true,
						 confirmation: true,
						 length: { minimum: 6 }
	before_create do 
		generate_token(:remember_token) 
		encrypt_password
	end

  before_update :encrypt_password

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

  def self.find_by_id(id)
    user = find(id: id)
    if user.empty?
      return nil
    else
      return user[0]
    end
  end

  def self.find_by_email(submitted_email)
    user = find(email: "#{submitted_email}")
    if user.empty?
      return nil
    else
      return user[0]
    end
  end

  def self.find_by_remember_token(remember_token)
    user = find(remember_token: "#{remember_token}") unless remember_token.nil?
    user.blank? ? nil : user[0]
  end

  def self.find_by_password_reset_token(password_reset_token)
    user = find(password_reset_token: 
              "#{password_reset_token}") unless password_reset_token.nil?
    user.blank? ? nil : user[0]
  end

	def admin?
		!self.admin.nil?
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
