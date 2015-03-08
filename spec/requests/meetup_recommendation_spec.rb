require 'rails_helper'

VCR.configure do |config|
  config.cassette_library_dir = "spec/fixtures/vcr_cassettes"
  config.hook_into :webmock
end

RSpec.describe "Meetup Recommendations", :type => :request do
  describe "User's Recommendations" do
    it "can suggested events to users based on the keywords from the events they've
      attended in the past" do
      VCR.use_cassette("recommended_events") do
        user = create(:user)
        user.store_past_events

        expect(user.recommend_events).to eq("")
      end
    end
  end
end
