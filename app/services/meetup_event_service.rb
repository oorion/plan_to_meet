require 'ruby_meetup'

class MeetupEventService
  attr_reader :user, :api_key_client

  def initialize(user="")
    @user = user
    RubyMeetup::ApiKeyClient.key = ENV['MEETUP_API_KEY']
    @api_key_client = RubyMeetup::ApiKeyClient.new
  end

  def past_events
    past_events_data = api_key_client.get_path(
      "/2/events",
      {:member_id => user.uid, :status => "past", :rsvp => "yes"}
    )
    parse(past_events_data)["results"]
  end

  private

  def parse(data)
    JSON.parse(data)
  end
end
