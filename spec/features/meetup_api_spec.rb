require 'rails_helper'

VCR.configure do |config|
  config.cassette_library_dir = "spec/vcr_cassettes"
  config.hook_into :webmock
end

RSpec.describe "Meetup Api", :type => :feature do
  describe "Meetup Api responses" do
    it "can be used to get a user's past events attended" do
      VCR.use_cassette("new_user_past_events") do
        user = create(:user)
        past_events = user.get_past_events
        past_events.each do |past_event|
          past_event["datetime"] = (past_events.first["utc_offset"] + past_events.first["time"]).to_s
        end

        user.store_past_events

        expect(user.events.first.name).to eq(past_events.first["name"])
        expect(user.events.first.description).to eq(past_events.first["description"])
        expect(user.events.first.datetime).to eq(past_events.first["datetime"])
        expect(user.events.count).to eq(20)
      end
    end
  end
end
