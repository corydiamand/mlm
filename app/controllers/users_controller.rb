class UsersController < ApplicationController
  before_filter :signed_in_user, only: [:show, :edit, :update]
  before_filter :correct_user, only: [:show, :edit, :update]
  before_filter :admin_user, only: :index
  before_filter :admin_view_statements, only: :show

  def index
    @users = User.order('last_name ASC').paginate(page: params[:page])
  end

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

  def search
    params[:user].delete(:search_name_id) if params.include?(:search_name_id)
    respond_to do |format|
      format.json { render json: found_users }
      format.html { find_user }
    end
  end

  private

  def found_users
    query_users
    @found_users.map do |user|
      {label: "#{user.last_name}, #{user.first_name}",
       id: "#{user.id}"}
    end 
  end

  def query_users
    @found_users = User.order(:last_name, :first_name).where(
      "CONCAT(last_name, ' ' ,first_name) like ? OR 
       CONCAT(first_name, ' ', last_name) like ?", 
       "%#{params[:term]}%", "%#{params[:term]}%")
  end

  def find_user
    return_searched_user
    if @user.nil?
      flash[:warning] = 'No users found'
      redirect_to users_path
    else
      redirect_to user_path(@user) 
    end
  end

  def return_searched_user
    begin
      @user = User.find("#{params[:user][:search_name_id]}")
    rescue ActiveRecord::RecordNotFound
      names = params[:user][:search_name].split(', ')
      @user = User.find_by_last_name_and_first_name(names[0],names[1])
    end
  end

    def admin_user
      redirect_to(root_path) unless current_user.admin?
    end

    def admin_view_statements
      if current_user.admin?
        @statements = User.find(params[:id]).statements
      else  
        @statements = current_user.statements
      end
    end
end
