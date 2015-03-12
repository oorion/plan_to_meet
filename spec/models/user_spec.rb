require 'rails_helper'

RSpec.describe User, :type => :model do
  it "can get the events associated with itself" do
    event = create(:event)
    user = event.users.first

    expect(user.events.first).to eq(event)
  end

  it "can determine when the user has no past events associated with it" do
    user = create(:user)

    expect(user.events?).to be false
  end

  it "can determine when the user has past events associated with it" do
    event = create(:event)
    user = event.users.first

    expect(user.events?).to be true
  end

  it "can store past events associated with the user provided they haven't already
    been stored in the database" do
    user = create(:user)
    #user.stub(:get_past_events) {
    allow(user).to receive(:get_past_events).and_return(
      [{
        "name" => "test name",
        "description" => "test description",
        "utc_offset" => 1413417600000,
        "time" => 1000000,
        "id" => "112233"
      }]
    )
    #}

    user.store_past_events
    user.store_past_events

    expect(user.events.count).to eq(1)
  end

end
