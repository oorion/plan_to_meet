require 'rails_helper'

RSpec.describe Api::V1::UsersController, :type => :controller do
  describe "GET index" do
    it "can return the index" do
      binding.pry
      events = create_list(:event, 10)
      get :index, format: :json

      expect(response.status).to eq(200)
    end
  end
end
