require 'rails_helper'

VCR.configure do |config|
  config.cassette_library_dir = "spec/fixtures/vcr_cassettes"
  config.hook_into :webmock
end

RSpec.describe "UserLogins", :type => :request do
  describe "GET /" do
    xit "can get a new user's access_token" do
      VCR.use_cassette("new_user") do
        get root_path
        click_link_or_button("Sign up with Meetup")

        connection = MeetupEventService.new(User.first)
        past_events = connection.past_events
        Event.create_events(past_events)
      end
    end
  end
end
