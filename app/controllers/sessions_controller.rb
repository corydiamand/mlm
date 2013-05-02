class SessionsController < ApplicationController
  def new
  end

  def create
  	user = User.authenticate(params[:email], params[:password])

  	if user.nil?
  		flash.now[:error] = "Invalid email/password combination"
  		render 'static_pages/home'
  	else
  		sign_in user
      if current_user.admin?
        redirect_to users_path
      else 
        redirect_to user_path(user)
      end
  	end
  end

  def destroy
    sign_out
    redirect_to root_path
  end
end

