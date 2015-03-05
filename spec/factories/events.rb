FactoryGirl.define do
  factory :event do
    name "Hack night"
    description "A night to hack on projects"
    group nil
    user
    address nil
  end
end
