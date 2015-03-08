require_relative "../../lib/meetup_query"
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

  def events?
    events.length > 0
  end

  def store_past_events
    get_past_events_data.each do |event_data|
      cleaned_event_data = Event.clean_event_data(event_data)
      events << Event.create(cleaned_event_data)
    end
  end

  def get_past_events_data
    meetup_query = MeetupQuery.new(self)
    meetup_query.get_past_user_events_data
  end

  def recommend_events
    recommendation_engine = RecommendationEngine.new(self)
    recommendation_engine.recommend_events
  end
end
