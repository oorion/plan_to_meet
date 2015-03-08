require 'ruby_meetup'

class MeetupQuery
  attr_reader :user, :api_key_client

  def initialize(user="")
    @user = user
    RubyMeetup::ApiKeyClient.key = ENV['MEETUP_API_KEY']
    @api_key_client = RubyMeetup::ApiKeyClient.new
  end

  def get_past_user_events_data
    json_data = api_key_client.get_path(
      "/2/events",
      {:member_id => user.uid, :status => "past", :rsvp => "yes"}
    )
    parsed_json = JSON.parse(json_data)
    parsed_json["results"]
  end
end
