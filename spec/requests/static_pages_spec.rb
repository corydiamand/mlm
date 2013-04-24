require 'spec_helper'

describe "Static pages" do
	subject { page }

	describe "Home page" do
		before { visit root_path }

		it { should have_selector('title', text: 'MLM Portal') }
		it { should have_selector('h2', text: 'Missing Link Music Client Portal')}
		it { should have_link('logo', href: root_path )}
		it { should have_link('Forgot Password?', href: new_password_reset_path )}

	end

	describe "Sign-in form" do
		before { visit root_path }

		##it { should have_button('Sign in') }
	end
end