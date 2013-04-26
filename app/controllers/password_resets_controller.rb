class PasswordResetsController < ApplicationController
  def new
  end

  def create
  	user = User.find_by_email(params[:email])
  	user.send_password_reset if user
  	flash[:notice] = "Email sent with password reset instructions"
  	redirect_to root_url
  end

  def edit
  	@user = User.find_by_password_reset_token(params[:id])
  end

  def update
  	@user = User.find_by_password_reset_token(params[:id])
  	time = Time.zone.parse(@user.password_reset_sent_at)
  	if time < 2.hours.ago
  		redirect_to new_password_reset_path 
  		flash[:alert] = "Password reset has expired"
  	else
  		begin
  			@user.update_attributes!(params[:user])
  			redirect_to root_url
  			flash[:notice] = "Password has been reset!"
  		rescue 
  			render 'edit'
  		end
  	end
  end
end

