require 'ruby_meetup'

class MeetupQuery
  attr_reader :client

  def initialize
    RubyMeetup::ApiKeyClient.key = ENV['MEETUP_API_KEY']
    @client = RubyMeetup::ApiKeyClient.new

    #client = RubyMeetup::AuthenticatedClient.new
    #client.access_token = user.access_token
    #json_s = client.get_path("/2/groups", {:member_id => user.member_id})
  end

  def past_user_events(member_id)
    json_data = client.get_path(
      "/2/events",
      {:member_id => member_id, :status => "past", :rsvp => "yes"}
    )
    parsed_json = JSON.parse(json_data)
    parsed_json["results"]
  end
end
