# frozen_string_literal: true

require 'rails_helper'

RSpec.describe SortedCustomers do
  describe '#sort_direction' do
    it 'returns desc if passed in as the original' do
      sorted_customers = described_class.new(sort_column: nil, original_sort_direction: :desc)
      expect(sorted_customers.sort_direction).to eq :desc
    end

    it 'returns asc if passed in as the original' do
      sorted_customers = described_class.new(sort_column: nil, original_sort_direction: :asc)
      expect(sorted_customers.sort_direction).to eq :asc
    end

    it 'returns asc if an unrecognized original value is passed in' do
      sorted_customers = described_class.new(sort_column: nil, original_sort_direction: :anything)
      expect(sorted_customers.sort_direction).to eq :asc
    end
  end

  describe '#sort_column' do
    it 'returns the value passed in' do
      sorted_customers = described_class.new(sort_column: :full_name, original_sort_direction: :anything)
      expect(sorted_customers.sort_column).to eq :full_name
    end
  end

  describe '#sorted_customers' do
    it 'sorts customers with vehicles by full name ascending' do
      bob_a = create :customer, :with_vehicle, first_name: 'Bob', last_name: 'A'
      bob_z = create :customer, :with_vehicle, first_name: 'Bob', last_name: 'Z'
      sally = create :customer, :with_vehicle, first_name: 'Sally'

      sorted_customers = described_class.new(sort_column: :full_name, original_sort_direction: :asc)
      expect(sorted_customers.customers.to_a).to eq [bob_a, bob_z, sally]
    end

    it 'sorts customers with vehicles by full name ascending' do
      bob_a = create :customer, :with_vehicle, first_name: 'Bob', last_name: 'A'
      bob_z = create :customer, :with_vehicle, first_name: 'Bob', last_name: 'Z'
      sally = create :customer, :with_vehicle, first_name: 'Sally'

      sorted_customers = described_class.new(sort_column: :full_name, original_sort_direction: :desc)
      expect(sorted_customers.customers.to_a).to eq [sally, bob_z, bob_a]
    end

    it 'sorts customers with vehicles by vehicle type ascending' do
      sailboat = create :vehicle, :sailboat
      bicycle = create :vehicle, :bicycle
      motorboat = create :vehicle, :motorboat

      sorted_customers = described_class.new(sort_column: :vehicle_type, original_sort_direction: :asc)
      expect(sorted_customers.customers.to_a).to eq [bicycle.customer, motorboat.customer, sailboat.customer]
    end

    it 'sorts customers with vehicles by vehicle type descending' do
      sailboat = create :vehicle, :sailboat
      bicycle = create :vehicle, :bicycle
      motorboat = create :vehicle, :motorboat

      sorted_customers = described_class.new(sort_column: :vehicle_type, original_sort_direction: :desc)
      expect(sorted_customers.customers.to_a).to eq [sailboat.customer, motorboat.customer, bicycle.customer]
    end
  end
end
