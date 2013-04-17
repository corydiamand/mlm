include ApplicationHelper

def sign_in(user)
	visit root_path
	fill_in "Email", 	 with: user.email
	fill_in "Password",  with: user.password
	click_button "Sign in"
	cookies[:remember_token] = [user.id, user.salt]
end