require 'rails_helper'
require 'event'

RSpec.describe Event, :type => :model do
  it "can find the users associated with itself if it is a past event" do
    user = create(:user)
    event = create(:event)

    expect(event.users.first.email).to eq(user.email)
  end
end
