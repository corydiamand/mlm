class WorksController < ApplicationController
  before_filter :signed_in_user, only: :index
  before_filter :correct_user, only: :index
  before_filter :admin_view_works, only: :index

  def index
  end

end

def admin_view_works
  if current_user.admin?
    @works = User.find(params[:id]).works.order('title ASC')
  else  
    @works = current_user.works.order('title ASC')
  end
end
