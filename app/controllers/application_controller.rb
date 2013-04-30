class ApplicationController < ActionController::Base
  protect_from_forgery
  include SessionsHelper

  private

    def authenticate
      deny_access unless signed_in?
    end

    def correct_user
      @user = User.find_by_id(params[:id])
      redirect_to(root_path) unless current_user?(@user) || current_user.admin?
    end
end
