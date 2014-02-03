class Admin::StatementsController < Admin::ApplicationController
  before_filter :admin_current_user, only: [:index]
  before_filter :admin_user, only: [:indexall]

  def index
    @statements = @user.statements
    render "statements/index"
  end

  def indexall
  	@statements = Statement.includes(:user).find(:all, :order => "date").paginate(page: params[:page],:per_page => 50)
  end

end
