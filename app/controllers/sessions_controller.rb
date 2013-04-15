class SessionsController < ApplicationController
  def new
  end

  def create
  	user = User.authenticate(params[:session][:email],
  							 params[:session][:password])

  	if user.nil?
  		#Create error
  	else
  		#Sign in
  	end
  end
end
