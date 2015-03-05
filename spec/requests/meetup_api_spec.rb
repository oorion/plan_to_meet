require 'rails_helper'
require 'event'
require 'meetup_query'

VCR.configure do |config|
  config.cassette_library_dir = "spec/fixtures/vcr_cassettes"
  config.hook_into :webmock
end

RSpec.describe "Meetup Api", :type => :request do
  describe "Meetup Api responses" do
    it "can be convert to models" do
      VCR.use_cassette("past_events") do
        user = create(:user)
        meetup_query = MeetupQuery.new(user)
        past_user_events = meetup_query.past_user_events
        Event.create_events(past_user_events)

        expect(Event.first.name).to eq("Hack night")
        expect(Event.first.description).to include("Bring your laptop, something to work on or your questions")
      end
    end
  end
end
