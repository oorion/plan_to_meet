require 'rails_helper'

RSpec.describe Recommendation, :type => :model do
  it "can identify upcoming events for a user with a desciption and/or name
    that contains keywords from past events that the user had attended" do
    event = create(:event)
    user = event.users.first
  end
end
