class Admin::StatementsController < Admin::ApplicationController
  before_filter :admin_current_user, only: [:index]
  before_filter :admin_user, only: [:indexall]

  def index
    user = User.find(params[:user_id])
    @statements = Statement.where(:web_id => user.web_id)
    render "statements/index"
  end

  def indexall
  	@statements = Statement.find(:all, :order => "created_at").paginate(page: params[:page],:per_page => 50)
  end

  def destroy
  	Statement.destroy(params[:id])
  	redirect_to :back
  	flash[:success] = "Successfully deleted statement."
  end

end
