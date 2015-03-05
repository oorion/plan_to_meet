require 'rails_helper'
require 'meetup_query'

VCR.configure do |config|
  config.cassette_library_dir = "spec/fixtures/vcr_cassettes"
  config.hook_into :webmock
end

RSpec.describe MeetupQuery do
  it "can query the meetup.com api and get event name and description" do
    VCR.use_cassette("past_events") do
      user = create(:user)
      meetup_query = MeetupQuery.new(user)
      past_user_events = meetup_query.past_user_events

      expect(past_user_events.first["name"]).to eq("Hack night")
    end
  end
end
