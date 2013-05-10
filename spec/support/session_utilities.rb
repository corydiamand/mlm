include ApplicationHelper

def sign_in_through_ui(user)
	visit root_path
	fill_in "Email", 	 with: user.email
	fill_in "Password",  with: user.password
	click_button "Sign in"
	#cookies[:remember_token] = user.remember_token
end

def sign_in_request(user)
  post sessions_path(email: user.email, password: user.password)
  cookies[:remember_token] = user.remember_token
end

def sign_out_request(user)
  delete signout_path 
  cookies[:remember_token] = nil
end
