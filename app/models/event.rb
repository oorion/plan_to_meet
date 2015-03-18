class Event < ActiveRecord::Base
  belongs_to :group
  belongs_to :address

  has_many :user_events
  has_many :users, through: :user_events

  validates :meetup_event_id, uniqueness: true

  def self.clean_event_data(event_data)
    cleaned_event_data = event_data.select do |k, v|
      k == "name" || k == "description" || k == "id"
    end
    cleaned_event_data["meetup_event_id"] = cleaned_event_data["id"].to_s
    cleaned_event_data.delete("id")
    cleaned_event_data["datetime"] = (event_data["utc_offset"] + event_data["time"]).to_s
    cleaned_event_data
  end
end
