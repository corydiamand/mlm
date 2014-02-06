class Admin::PortalUpdatesController < Admin::ApplicationController
	before_filter :admin_user

	def home
	end

	def index
		@last_update = PortalUpdate.last
		@last_update_user = User.find(@last_update.user_id)
	end

	def create
		PortalUpdate.create(:date =>Time.now, :user_id => current_user.id)
		redirect_to :back
		flash[:success] = "Update in progress"
	end

	def update_portal
		cat = Catalyst.new
		redirect_to index_path
	end
end