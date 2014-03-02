class Admin::StatementsController < Admin::ApplicationController
  before_filter :admin_current_user, only: [:index]
  before_filter :admin_user, only: [:indexall]

  def index
    user = User.find(params[:user_id])
    @statements = Statement.where(:web_id => user.web_id)
  end

  def indexall
    if params[:direction] != nil && params[:sort] != nil
      if params[:direction] == "asc"
        @statements = Statement.reorder(params[:sort]).paginate(page: params[:page],:per_page => 100)
      elsif params[:direction] == "desc"
        @statements = Statement.reorder(params[:sort]).reverse.paginate(page: params[:page],:per_page => 100)
      end
    else
      @statements = Statement.find(:all, :order => "created_at").paginate(page: params[:page],:per_page => 100)
    end
  end

  def destroy
  	Statement.destroy(params[:id])
  	redirect_to :back
  	flash[:success] = "Successfully deleted statement."
  end

end
