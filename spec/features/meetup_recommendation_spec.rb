require 'rails_helper'

VCR.configure do |config|
  config.cassette_library_dir = "spec/vcr_cassettes"
  config.hook_into :webmock
end

RSpec.describe "Meetup Recommendations", :type => :feature do
  describe "User's Recommendations" do
    it "can suggested events to users based on the keywords from the events they've
      attended in the past" do
      VCR.use_cassette("recommended_events") do
        user = create(:user)
        user.store_past_events
        recommended_events = user.recommend_events
        expect(recommended_events.first.id).to eq("221328648")
      end
    end
  end
end
