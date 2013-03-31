require 'spec_helper'

describe "/api/v1/identities", type: :api do

  describe "#create" do
    it "should accept a valid email, password, password confirmation" do
      expect {
        post '/api/v1/signup', identity: {email: 'happy@stuff.com', password: 'crabcakes', password_confirmation: 'crabcakes'}
      }.to change(Identity, :count).by 1
    end

    it "should reject passwords that don't match confirmation" do
      expect {
        post '/api/v1/signup', identity: {email: 'happy@stuff.com', password: 'carcinogens', password_confirmation: 'crabcakes'}
      }.to change(Identity, :count).by 0
    end

    it "should reject blank emails" do
      expect {
        post '/api/v1/signup', identity: {password: 'crabcakes', password_confirmation: 'crabcakes'}
      }.to change(Identity, :count).by 0
    end

    it "should return json and maybe a session cookie?"
  end
end