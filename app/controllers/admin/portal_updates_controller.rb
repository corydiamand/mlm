class Admin::PortalUpdatesController < Admin::ApplicationController
	before_filter :admin_user

	def home
	end

	def index
		@last_update = PortalUpdate.last
		if @last_update != nil  
			@last_update_user = User.find(@last_update.user_id) 
		else
		end
	end

	def create
		PortalUpdate.create(:date =>Time.now, :user_id => current_user.id)
		begin
			status = Timeout::timeout(20){
			database = PortalUpdates::Catalyst.new
			database.post_new_users
			database.post_new_statements
			}
		rescue Exception => e
			redirect_to :back
			flash[:error] = "Update failed!  #{e}"
		else
			redirect_to :back
			flash[:success] = "Updated successfully"		
		end
	end

	def update_portal
		cat = Catalyst.new
		redirect_to index_path
	end

end