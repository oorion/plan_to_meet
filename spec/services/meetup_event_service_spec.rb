require 'rails_helper'

VCR.configure do |config|
  config.cassette_library_dir = "spec/vcr_cassettes"
  config.hook_into :webmock
end

RSpec.describe MeetupEventService do
  it "can query the meetup.com api and get event name and description" do
    VCR.use_cassette("past_events") do
      user = create(:user)
      connection = MeetupEventService.new(user)
      past_events = connection.past_events

      expect(past_events.first["name"]).to eq("Hack night")
    end
  end
end
