class ApplicationController < ActionController::Base
  protect_from_forgery
  include SessionsHelper

   # Force signout to prevent CSRF attacks
  def handle_unverified_request
    sign_out
    super
  end

  private

    def signed_in_user
      deny_access unless signed_in?
    end

    def correct_user
      @user = User.find_by_id(params[:id])
      redirect_to(root_path) unless current_user?(@user) || current_user.admin?
    end
end
