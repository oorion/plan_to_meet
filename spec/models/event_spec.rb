require 'rails_helper'
require 'event'

RSpec.describe Event, :type => :model do
  it "can find the users associated with itself if it is a past event" do
    event = create(:event)

    expect(event.users.first.email).to eq(User.first.email)
  end

  it "cannot create two events with the same meetup_event_id" do
    event1 = build(:event)
    event2 = build(:event)

    expect(event1.save).to be true
    expect(event2.save).to be false
  end
end
