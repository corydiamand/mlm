include ApplicationHelper

def request_new_password(user)
  visit new_password_reset_path
  fill_in 'Email',    with: @user.email
  click_button 'Reset Password'
  user.reload
end