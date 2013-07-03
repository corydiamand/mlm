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
      @user = User.find(params[:user_id]) if params.include?(:user_id)
      @user ||= User.find(params[:id])
      redirect_to(root_path) unless current_user?(@user) || current_user.admin?
    end

    def admin_user
      redirect_to(root_path) unless current_user.admin?
    end

    def pending_count
      if current_user.admin?
        @user_notifications ||= User.pending.count
        @work_notifications ||= Work.pending.count
      end
    end
    
end
