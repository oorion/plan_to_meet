class Event < ActiveRecord::Base
  belongs_to :group
  belongs_to :address

  has_many :user_events
  has_many :users, through: :user_events

  def self.clean_event_data(event_data)
    cleaned_event_data = event_data.select do |k, v|
      k == "name" || k == "description"
    end
    cleaned_event_data["datetime"] = (event_data["utc_offset"] + event_data["time"]).to_s
    cleaned_event_data
  end
end
