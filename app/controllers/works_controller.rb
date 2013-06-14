class WorksController < ApplicationController
  include WorksHelper
  before_filter :signed_in_user, only: :index
  before_filter :correct_user, only: :index
  before_filter :admin_view_works, only: :index

  def index
  end

  def new
    @work = Work.new
    @current_claim = @work.work_claims.build
  end

  def create
    @work = Work.new(params[:work])
    if @work.save
      flash[:success] = "Successfully submitted work"
      redirect_to user_works_path current_user
    else
      render action: 'new'
    end
  end
end

def admin_view_works
  if current_user.admin?
    @works = User.find(params[:user_id]).works.order('title ASC')
  else  
    @works = current_user.works.order('title ASC')
  end
end












  
