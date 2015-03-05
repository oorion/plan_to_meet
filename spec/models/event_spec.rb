require 'rails_helper'
require 'event'

RSpec.describe Event, :type => :model do
  it "can find the users associated with itself if it is a past event" do
    event = create(:event)
    expect(event.users.first.email).to eq(User.first.email)
  end
end
