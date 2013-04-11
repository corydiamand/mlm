require 'spec_helper'

describe "Static pages" do
	before { visit root_path }

	subject { page }

	it { should have_selector('title', text: 'MLM Portal') }
end