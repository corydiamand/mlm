class Admin::WorksPendingController < Admin::ApplicationController
  before_filter :pending_works

  def index
  end

  def update
    begin 
      params[:pending].each do |work_id, updated_tag|
        @works_pending.find(work_id).update_column(:pending, false) 
      end
      flash[:success] = "Work status updated"
      redirect_to admin_users_path
    rescue
      flash.now[:error] = "No works selected"
      render 'index'
    end
  end

  private

  def pending_works
    @works_pending = Work.pending
  end

end
