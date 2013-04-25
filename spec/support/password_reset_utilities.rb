include ApplicationHelper

def request_new_password(user)
  visit root_path
  click_button 'Forgot Password?'
  fill_in 'Email',    with: @user.email
  click_button 'Reset Password'
end