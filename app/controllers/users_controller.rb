class UsersController < ApplicationController
	before_filter :authenticate, only: [:show, :update]

	def index
	end

	def show
		@user = User.find_by_id(params[:id])
	end
	
	def update
	end

	private

		def authenticate
			deny_access unless signed_in?
		end
end
