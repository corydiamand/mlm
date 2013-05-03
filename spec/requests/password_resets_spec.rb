require 'spec_helper'

describe "PasswordResets" do
  let(:user) { FactoryGirl.create(:user) }

  it "emails user when requesting password" do
    post password_resets_path(email: user.email)
    last_email.to.should include(user.email)
  end

  it "does not email invalid user" do
    post password_resets_path(email: 'invalid@invalid.inv')
    last_email.should be_nil
  end
end
