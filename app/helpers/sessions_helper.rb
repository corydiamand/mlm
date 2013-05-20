module SessionsHelper

	def sign_in(user)
		cookies.permanent[:remember_token] = user.remember_token
		self.current_user = user
	end

	def signed_in?
		!current_user.nil?
	end

	def current_user=(user)
		@current_user = user
	end

	def current_user
		@current_user ||= User.find_by_remember_token(
			cookies[:remember_token]) unless cookies[:remember_token].nil?
	end

	def current_user?(user)
		user == current_user
	end

	def sign_out
		self.current_user = nil
		cookies.delete(:remember_token)
	end

	def deny_access
		redirect_to root_path, notice: "Please sign in to access this page."
	end

	def current_claim(wc)
  	if wc.user == self.current_user
      wc.mr_share
   elsif self.current_user.admin?
   		wc.mr_share if wc.user == User.find(params[:id])
   	end
  end
end
