# frozen_string_literal: true

FactoryBot.define do
  factory :vehicle do
    vehicle_type { 'sailboat' }
    sequence(:name) { |n| "Vehicle #{n}" }
    length_feet { rand(11..40) }

    association :customer

    trait :sailboat do
      vehicle_type { 'sailboat' }
    end

    trait :bicycle do
      vehicle_type { 'bicycle' }
    end

    trait :motorboat do
      vehicle_type { 'motorboat' }
    end
  end
end
