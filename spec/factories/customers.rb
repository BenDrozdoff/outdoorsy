# frozen_string_literal: true

FactoryBot.define do
  factory :customer do
    sequence(:first_name) { |n| "First#{n}" }
    sequence(:last_name) { |n| "Last#{n}" }
    sequence(:email) { |n| "customer#{n}@gmail.com" }

    trait :with_vehicle do
      after(:build) do |customer|
        build :vehicle, customer: customer
      end
    end
  end
end
