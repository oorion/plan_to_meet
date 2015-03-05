FactoryGirl.define do
  factory :user do
    uid 9937129
    sequence :email do |n|
      "test#{n}@example.com"
    end
  end
end
