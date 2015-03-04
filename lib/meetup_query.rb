require 'ruby_meetup'

class MeetupQuery
  attr_reader :client

  def initialize
    RubyMeetup::ApiKeyClient.key = ENV['MEETUP_API_KEY']
    @client = RubyMeetup::ApiKeyClient.new
  end

  def events
    json_data = client.get_path(
      "/2/events",
      {:member_id => 9937129, :status => "past", :rsvp => "yes"}
    )
    parsed_json = JSON.parse(json_data)
    parsed_json["results"]
  end
end
