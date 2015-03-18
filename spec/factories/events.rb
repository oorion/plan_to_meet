FactoryGirl.define do
  factory :event do
    name "Hack night"
    description "A night to hack on projects"
    group nil
    address nil
    datetime "1413396000000"
    meetup_event_id "112233"

    before(:create) do |event|
      event.users << create(:user)
    end
  end
end
