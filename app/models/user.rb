class User < Rfm::Base
	config :layout => 'Users'
	attr_accessor :password
end
