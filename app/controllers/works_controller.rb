class WorksController < ApplicationController
  include WorksHelper
  before_filter :signed_in_user, only: [:index, :edit, :update]
  before_filter :correct_user, only: [:index]
  before_filter :correct_claim, only: [:edit, :update]
  before_filter :set_current_work, only: [:edit, :update]

  def index
    @works = current_user.works.order('title ASC').includes(:audio_products, work_claims: :user)
    @current_user = current_user
  end

  def new
    @work = Work.new
    @current_claim = @work.work_claims.build
  end

  def create
    #puts params[:work].inspect
    @work = Work.new(params[:work])
    if @work.save
      flash[:success] = "Successfully submitted work"
      redirect_to user_works_path current_user
    else
      render 'new'
    end
  end

  def edit
    @current_claim = @work.work_claims.select { |claim| claim.user == current_user}
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
    @work = Work.find(params[:id])
    @claim_users = @work.users
    redirect_to(root_path) unless @claim_users.include?(current_user)
  end

  def set_current_work
    @work = Work.find(params[:id])
  end

end












  
