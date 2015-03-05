FactoryGirl.define do
  factory :event do
    name "Hack night"
    description "A night to hack on projects"
    group nil
    address nil

    before(:create) do |event|
      event.users << create(:user)
    end
  end
end
