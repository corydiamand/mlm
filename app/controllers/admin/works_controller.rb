class Admin::WorksController < Admin::ApplicationController
  before_filter :admin_current_user, only: :index
  before_filter :admin_current_work, only: :show

  def index
    @works = @user.works.order('title ASC').includes(:audio_products, work_claims: :user)
    render 'works/index'
  end

  def show
    #@work ||= Work.find(params[:id])
  end

  def destroy
    Work.destroy(params[:id])
    redirect_to admin_user_works_path(params[:format])
    flash[:success] = "Successfully deleted work."
  end

end
