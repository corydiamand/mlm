class Admin::UsersController < Admin::ApplicationController
  before_filter :admin_current_user, only: :edit

  def index
    @users = User.order('last_name ASC').paginate(page: params[:page])
  end

  def edit
    render 'users/edit'
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
         "%#{params[:term].upcase}%", "%#{params[:term].upcase}%")
    end

    def find_user
      return_searched_user
      if @user.nil?
        flash[:warning] = 'No users found'
        redirect_to admin_users_path
      else
        redirect_to user_statements_path(@user)
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

end
