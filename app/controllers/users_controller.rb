class UsersController < ApplicationController
  skip_before_filter :verify_authenticity_token, only: [:create]
  before_filter :signed_in_user, only: [:show, :edit, :update]
  before_filter :correct_user, only: [:show, :edit, :update]
  before_filter :pending_count, except: [:create]
  
  def show
  end

  def create
    params.delete(:admin) if params.include?(:admin)
    @user = User.new(params[:user])
    if @user.save
      render json: @user.to_json
    else
      render json: @user.errors.to_json
    end
  end

  def edit
  end
  
  def update
    params.delete(:admin) if params.include?(:admin)
    @user = User.find(params[:id])
    if @user.update_attributes(params[:user])
      flash[:success] = "Account updated."
      sign_in @user
      redirect_to user_statements_path(@user)
    else
      render 'edit'
    end
  end
end

