require 'spec_helper'

describe "Authentication Requests" do

  before(:all) do
    @user = FactoryGirl.create(:user)
    @other_user = FactoryGirl.create(:user)
  end

  after(:all) do
    @user.destroy
    @other_user.destroy
  end

  context "as a guest user" do
    
    it "should not see a user's page" do
      get user_path(@user.id)
      response.should redirect_to(root_url)
    end

    it "should not see a user's edit page" do
      get edit_user_path(@user.id)
      response.should redirect_to(root_url)
    end

    it "should not update a user's page" do
      put user_path(@user.id)
      response.should redirect_to(root_url)
    end

    it "should not be able to view a user's statement" do
      get user_hosted_file_path(@user.id, 1)
      response.should redirect_to(root_url)
    end
  end

  context "as a non-admin wrong user" do
    before { sign_in_request @user }

    it "should not see another user's page" do
      get user_path(@other_user.id)
      response.should redirect_to(root_url)
    end

    it "should not see another user's edit page" do
      get edit_user_path(@other_user.id)
      response.should redirect_to(root_url)
    end

    it "should not update another user's page" do
      put user_path(@other_user.id)
      response.should redirect_to(root_url)
    end

    it "should not see the users index" do
      get users_path
      response.should redirect_to(root_url)
    end

    it "should not be able to update itself to admin status" do
      put user_path(@user.id, admin: 1)
      @user.should_not be_admin
    end

    it "should not be able to view another user's statement" do
      get user_hosted_file_path(@user.id, 1)
      response.should redirect_to(root_url)
    end
  end
end

