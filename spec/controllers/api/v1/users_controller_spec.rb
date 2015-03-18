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

  describe "GET show" do
    it "can return the recommended events" do
      user = create(:user)
      user.events << create(:event)
      allow_any_instance_of(User).to receive(:recommend_events).and_return([user.events.first])

      get :show, format: :json, id: user.id
      recommended_events = JSON.parse(response.body)

      expect(response.status).to eq(200)
      expect(recommended_events.first["name"]).to eq("Hack night")
    end
  end
end
