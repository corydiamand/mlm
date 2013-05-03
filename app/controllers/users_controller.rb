class UsersController < ApplicationController
	before_filter :signed_in_user, only: [:show, :edit, :update]
	before_filter :correct_user, only: [:show, :edit, :update]
	before_filter :admin_user, only: [:index]

	def index
		@users = User.order('last_name ASC').paginate(page: params[:page])
	end

	def show
		@microposts = current_user.statements
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

	private

		def admin_user
			redirect_to(root_path) unless current_user.admin?
		end
end
