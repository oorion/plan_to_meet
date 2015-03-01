require 'rails_helper'

RSpec.describe "UserLogins", :type => :request do
  describe "GET /user_logins" do
    it "works! (now write some real specs)" do
      get root_path
      expect(response).to have_http_status(200)
    end
  end
end
