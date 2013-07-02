class Admin::StatementsController < Admin::ApplicationController
  before_filter :admin_current_user

  def index
    @statements = @user.statements
    render "statements/index"
  end

end
