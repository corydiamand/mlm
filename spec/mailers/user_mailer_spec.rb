require "spec_helper"

describe UserMailer do
  let(:user) { FactoryGirl.create(:user) }
  before { user.password_reset_token = "etc" }

  describe "password_reset" do
    let(:mail) { UserMailer.password_reset(user) }

    it "sends user password reset url" do
      mail.subject.should eq("Password Reset")
      mail.to.should eq([user.email])
      mail.from.should eq(["no-reply@missinglinkmusic.com"])
      mail.body.encoded.should match(
                        edit_password_reset_path(user.password_reset_token))
    end
  end
end
