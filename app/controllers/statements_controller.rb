class StatementsController < ApplicationController
  skip_before_filter :verify_authenticity_token, only: [:create]
  before_filter :signed_in_user, only: :index
  before_filter :correct_user, only: :index

  def index
    @statements = current_user.statements
  end

  def create
    params.delete(:admin) if params.include?(:admin)
    @statement = Statement.new(params[:statement])
    if @statement.save
      render json: @statement.to_json
    else
      render json: @statement.errors.to_json
    end
  end
end
