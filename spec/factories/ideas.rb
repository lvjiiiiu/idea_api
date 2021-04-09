FactoryBot.define do
  factory :idea do
    sequence(:body) { |n| "aiueo#{n}"}
    association :category
  end
end
