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
end
