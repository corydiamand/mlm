class UsersController < ApplicationController
	before_filter :authenticate, only: [:show, :update]
	before_filter :correct_user, only: [:show, :update]
	before_filter :admin_user, only: [:index]

	def index
		@users = User.all.paginate(page: params[:page])
	end

	def show
	end
	
	def update
		@user = User.find(params[:id])
		#params.delete(:admin) if params.include?(:admin)
	end

	private

		def authenticate
			deny_access unless signed_in?
		end

		def correct_user
			@user = User.find_by_id(params[:id])
			redirect_to(root_path) unless current_user?(@user)
		end

		def admin_user
			redirect_to(root_path) unless current_user.admin?
		end
end
