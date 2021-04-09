FactoryBot.define do
  factory :category do
    sequence(:name) { |n| "TEST_NAME#{n}"}
  end
end
