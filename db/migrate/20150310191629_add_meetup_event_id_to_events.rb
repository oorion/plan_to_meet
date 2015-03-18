class AddMeetupEventIdToEvents < ActiveRecord::Migration
  def change
    add_column :events, :meetup_event_id, :string
  end
end
