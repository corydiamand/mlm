class WorksController < ApplicationController
  before_filter :signed_in_user, only: :index
  before_filter :correct_user, only: :index

  def index
    @works = current_user.works
  end

end
