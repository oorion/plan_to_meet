require 'rails_helper'
require 'meetup_query'

VCR.configure do |config|
  config.cassette_library_dir = "spec/fixtures/vcr_cassettes"
  config.hook_into :webmock
end

RSpec.describe MeetupQuery do
  it "can query the meetup.com api and get event name and description" do
    VCR.use_cassette("past_events") do
      meetup_query = MeetupQuery.new
      binding.pry
      expect(meetup_query.events.first["name"]).to eq("Hack night")
    end
  end
end
