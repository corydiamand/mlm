class UsersController < ApplicationController
  before_filter :signed_in_user, only: [:show, :edit, :update]
  before_filter :correct_user, only: [:show, :edit, :update]
  before_filter :pending_count
  
  def show
  end

  def edit
  end
  
  def update
    params.delete(:admin) if params.include?(:admin)
    @user = User.find(params[:id])
    if @user.update_attributes(params[:user])
      flash[:success] = "Account updated."
      sign_in @user
      redirect_to @user
    else
      render 'edit'
    end
  end
end

