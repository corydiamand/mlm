class SessionsController < ApplicationController
  def new
  end

  def create
  	user = User.find_by_email(params[:email].downcase)
  	if user && user.authenticate(params[:password])
      sign_in user
      current_user.admin? ? redirect_to(admin_users_path) : redirect_to(user_statements_path(user))
      flash[:success] = 'Successfully signed in!'
  	else
  		flash.now[:error] = "Invalid email/password combination"
      render 'static_pages/home'
  	end
  end

  def destroy
    sign_out
    redirect_to root_path
  end
end

