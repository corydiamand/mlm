class UsersController < ApplicationController
	before_filter :authenticate, only: [:show, :edit, :update]
	before_filter :correct_user, only: [:show, :edit, :update]
	before_filter :admin_user, only: [:index]

	def index
		@users = User.all.paginate(page: params[:page])
	end

	def show
	end

	def edit
	end
	
	def update
		#params.delete(:admin) if params.include?(:admin)
		@user = User.find_by_id(params[:id])
		begin @user.update_attributes!(params[:user])
			flash[:success] = "Account updated."
			redirect_to user_path(@user.id)
		rescue
			render 'edit'
		end
	end

	private

		def authenticate
			deny_access unless signed_in?
		end

		def correct_user
			@user = User.find_by_id(params[:id])
			redirect_to(root_path) unless current_user?(@user) || current_user.admin?
		end

		def admin_user
			redirect_to(root_path) unless current_user.admin?
		end
end
