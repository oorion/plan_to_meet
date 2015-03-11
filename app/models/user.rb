require_relative "../../lib/recommendation_engine"

class User < ActiveRecord::Base
  has_many :user_events
  has_many :events, through: :user_events

  validates_uniqueness_of :uid

  def self.find_or_create_from_auth(auth)
    user = User.find_or_create_by(uid: auth["uid"])
    user.access_token = auth["credentials"]["token"]
    if user.save
      user
    end
  end

  def store_past_events
    get_past_events.each do |event_data|
      cleaned_event_data = Event.clean_event_data(event_data)
      events.find_or_create_by(meetup_event_id: cleaned_event_data["meetup_event_id"]) do |user|
        user.name = cleaned_event_data["name"]
        user.description = cleaned_event_data["description"]
        user.datetime = cleaned_event_data["datetime"]
      end
    end
  end

  def get_past_events
    connection = MeetupEventService.new(self)
    connection.past_events
  end

  def events?
    events.count > 0
  end

  def recommend_events
    recommendation_engine = RecommendationEngine.new(self)
    recommendation_engine.recommend_events
  end
end
