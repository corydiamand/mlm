class WorksController < ApplicationController
  include WorksHelper
  before_filter :signed_in_user, only: [:index, :edit, :update]
  before_filter :correct_user, only: [:index]
  before_filter :correct_claim, only: [:edit, :update]
  before_filter :set_current_work, only: [:edit, :update]

  def index
    @works = current_user.works.order('title ASC')
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
      render 'new'
    end
  end

  def edit
  end

  def update
    if @work.update_attributes(params[:work])
      flash[:success] = "Work updated"
      redirect_to user_works_path current_user
    else
      render 'edit'
    end
  end


  private
  
  def correct_claim
    @claim_users = Work.find(params[:id]).users
    redirect_to(root_path) unless @claim_users.include?(current_user)
  end

  def set_current_work
    @work = Work.find(params[:id])
  end

end












  
