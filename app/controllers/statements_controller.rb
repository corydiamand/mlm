class StatementsController < ApplicationController
  before_filter :signed_in_user, only: :index
  before_filter :correct_user, only: :index

  def index
    @statements = current_user.statements
  end
end
