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
        recommended_events = user.recommend_events

        expect(recommended_events.sort).to eq(
          ["track", "entrepreneur", "beginner", "rails", "america", "hemeraproject", "polymorphism", "rebecca", "github", "startup", "meetup", "everyone", "civic", "cause5", "devices", "workshop", "leaflet", "plans", "intro", "craft", "ruby_in_100_minutes", "jumpstartlab", "tutorials", "breckenridge", "nonprofits", "scene", "light", "manley", "speaker", "networking", "going", "coffee", "dinner", "start", "business", "using", "presentations", "projects", "colorado", "primarily", "source", "unruh", "manipulation", "resources", "static", "dcc862cba55aa96aa014", "rwarbelow", "people", "bunch", "grabbing", "celebs", "right", "galiana", "fernand", "personal", "promise", "march", "questions", "laptop", "something", "bring"].sort
        )
      end
    end
  end
end
