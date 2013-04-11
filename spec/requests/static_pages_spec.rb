require 'spec_helper'

describe "Static pages" do

	subject { page }

	it { should have_selector('title', text: "MLM Portal") }
end