class Admin::SessionsController < Admin::ApplicationController
  before_filter :admin_user, only: [:index]

  def index
  	@sessions = Session.includes(:user).find(:all, :order => "created_at").paginate(page: params[:page],:per_page => 50)
  end

end
