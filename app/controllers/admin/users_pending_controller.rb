class Admin::UsersPendingController < Admin::ApplicationController
  before_filter :pending_users

  def index
  end

  def update
    begin 
      params[:pending].each do |user_id, updated_tag|
        @users_pending.find(user_id).update_column(:pending, false) 
      end
      flash[:success] = "User status updated"
      redirect_to admin_users_path
    rescue
      flash.now[:error] = "No users selected"
      render 'index'
    end
  end

  private

  def pending_users
    @users_pending = User.pending
  end

end
