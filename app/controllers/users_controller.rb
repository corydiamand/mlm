class UsersController < ApplicationController
	before_filter :signed_in_user, only: [:show, :edit, :update]
	before_filter :correct_user, only: [:show, :edit, :update]
	before_filter :admin_user, only: [:index]

	def index
		@users = User.order('last_name ASC').paginate(page: params[:page])
	end

	def show
		@statements = current_user.statements
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
		@users = User.order(:last_name, :first_name).where(
												"last_name like ? OR first_name like ?", "%#{params[:term]}%", "%#{params[:term]}%")
		render json: @users.map{ |user| {
			label: "#{user.last_name}, #{user.first_name}",
			value: "#{user.id}" } }
	end

	private

		def admin_user
			redirect_to(root_path) unless current_user.admin?
		end
end
