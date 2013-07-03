class Admin::ApplicationController < ApplicationController
  before_filter :signed_in_user
  before_filter :admin_user
  before_filter :pending_count

  private

  def admin_current_user
    @user ||= User.find(params[:user_id])
  end

  def admin_current_work
    @work ||= Work.find(params[:id])
  end

end