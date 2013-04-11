require 'spec_helper'

describe "Static pages" do
	subject { page }

	describe "Home page" do
		before { visit root_path }

		it { should have_selector('title', text: 'MLM Portal') }
		it { should have_selector('h1', text: 'Missing Link Music Client Portal')}
		it { should have_link('logo', href: root_path, src: '/assets/mlmlogo.png' )}
		
	end
end