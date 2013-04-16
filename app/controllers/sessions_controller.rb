class SessionsController < ApplicationController
  def new
  end

  def create
  	user = User.authenticate(params[:session][:email],
  							 params[:session][:password])

  	if user.nil?
  		flash.now[:error] = "Invalid email/password combination"
  		render 'static_pages/home'
  	else
  		#Sign in
  	end
  end
end
