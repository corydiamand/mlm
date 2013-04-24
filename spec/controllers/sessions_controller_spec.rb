require 'spec_helper'

describe SessionsController do
	render_views

	describe "invalid signin" do
		before(:each) do
			@attr = { email: "email@example.com", password: "invalid" }
		end

		it "should re-render the new page" do
			post :create, session: @attr
			response.should render_template('static_pages/home')
		end
	end
end