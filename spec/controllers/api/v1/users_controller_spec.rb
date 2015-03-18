require 'rails_helper'

RSpec.describe Api::V1::UsersController, :type => :controller do
  describe "GET index" do
    it "can return the index" do
      user = create(:user)
      user.events << create(:event)

      get :index, format: :json
      users = JSON.parse(response.body)

      expect(response.status).to eq(200)
      expect(users.first["email"]).to eq("test1@example.com")
    end
  end
end
