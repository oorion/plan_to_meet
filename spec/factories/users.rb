FactoryGirl.define do
  factory :user do
    uid 9937129
    phone_number "333-333-4444"
    sequence :email do |n|
      "test#{n}@example.com"
    end
  end
end
