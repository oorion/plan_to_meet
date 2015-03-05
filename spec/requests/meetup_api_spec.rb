require 'rails_helper'
require 'event_converter'

VCR.configure do |config|
  config.cassette_library_dir = "spec/fixtures/vcr_cassettes"
  config.hook_into :webmock
end

RSpec.describe "Meetup Api", :type => :request do
  describe "Meetup Api responses" do
    it "can be convert to models" do
      VCR.use_cassette("past_events") do
        meetup_query = MeetupQuery.new
        EventConverter.convert_events(meetup_query.events)

        expect(Event.first.name).to eq("Hack night")
        expect(Event.first.description).to include("Bring your laptop, something to work on or your questions")
      end
    end
  end
end
