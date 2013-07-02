class Admin::WorksController < Admin::ApplicationController
  before_filter :admin_current_user, only: :index
  before_filter :admin_current_work, only: :show

  def index
    @works = @user.works.order('title ASC')
    render 'works/index'
  end

  def show
  end

end
