require 'spec_helper'

describe "IdentitiesController", :type => :controller do
  controller(IdentitiesController) do end
    
  describe "#create" do
    it "should accept an email, password, password confirmation" do
      expect {
        post :create, identity: {email: 'happy@stuff.com', password: 'yolofuckers', password_confirmation: 'yolofuckers'}
      }.to change(Identity, :count).by 1
    end

    it "a valid email and password should return json and maybe a session cookie?"
  end
end