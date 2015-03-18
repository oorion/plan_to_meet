#require_relative "../../../lib/recommendation_engine"

class User < ActiveRecord::Base
  include ActiveModel::Validations

  has_many :user_events
  has_many :events, through: :user_events

  validates_uniqueness_of :uid
  validates :email, allow_blank: true, email: true
  validates :phone_number, allow_blank: true, format: { with: /\d{3}-*\d{3}-*\d{4}/, message: "Invalid phone number" }

  def self.find_or_create_from_auth(auth)
    user = User.find_or_create_by(uid: auth["uid"])
    user.access_token = auth["credentials"]["token"]
    if user.save
      user
    end
  end

  def store_past_events
    get_past_events.each do |event_data|
      event = Event.find_by(meetup_event_id: event_data["id"])
      if event.nil?
        cleaned_event_data = Event.clean_event_data(event_data)
        events.create(cleaned_event_data)
      elsif !user_event_already_exists?(event)
        events << event
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
    upcoming_events = get_upcoming_events
    recommendation_engine = RecommendationEngine.new(self)
    @recommended_events ||= recommendation_engine.recommend_events(upcoming_events)
  end

  def get_upcoming_events
    connection = MeetupEventService.new(self)
    connection.upcoming_events
  end

  def send_top_recommendation_text(phone_number)
    event_name = recommend_events.first.name
    event_url = recommend_events.first.event_url
    message = "Plan To Meet Recommendation:  #{event_name} => #{event_url}"
    text(phone_number, message)
  end

  private

  def user_event_already_exists?(event)
    user_events.find { |user_event| user_event.event_id == event.id }
  end

  def text(phone_number, message)
    twilio_sid = ENV["TWILIO_SID"]
    twilio_auth_token = ENV["TWILIO_AUTH_TOKEN"]
    @client = Twilio::REST::Client.new twilio_sid, twilio_auth_token
    @client.account.messages.create({
      from: "+15059338671",
      to: phone_number,
      body: message
    })
  end
end
