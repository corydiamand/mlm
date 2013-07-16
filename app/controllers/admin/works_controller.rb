class Admin::WorksController < Admin::ApplicationController
  before_filter :admin_current_user, only: :index
  before_filter :admin_current_work, only: :show

  def index
    @works = @user.works.order('title ASC').includes(:audio_products, work_claims: :user)
    render 'works/index'
  end

  def show
  end

end
