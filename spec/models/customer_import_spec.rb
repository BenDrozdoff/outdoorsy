# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CustomerImport do
  describe '#create!' do
    it 'creates the customer and vehicle' do
      file_text = 'bob,boater,bob.boater@example.com,sailboat,Bobs Sailboat,20 feet'
      expect { described_class.new(file_text).create! }
        .to change(Customer, :count).from(0).to(1)
                                    .and change(Vehicle, :count).from(0).to(1)

      expect(Customer.last).to have_attributes(first_name: 'bob', last_name: 'boater', email: 'bob.boater@example.com')
      expect(Vehicle.last).to have_attributes(vehicle_type: 'sailboat', name: 'Bobs Sailboat', length_feet: 20)
      expect(Vehicle.last.customer.email).to eq 'bob.boater@example.com'
    end

    it 'can use a pipe delimiter' do
      file_text = 'bob|boater|bob.boater@example.com|sailboat|Bobs Sailboat|20 feet'

      expect { described_class.new(file_text).create! }
        .to change(Customer, :count).from(0).to(1)
                                    .and change(Vehicle, :count).from(0).to(1)

      expect(Customer.last).to have_attributes(first_name: 'bob', last_name: 'boater', email: 'bob.boater@example.com')
      expect(Vehicle.last).to have_attributes(vehicle_type: 'sailboat', name: 'Bobs Sailboat', length_feet: 20)
      expect(Vehicle.last.customer.email).to eq 'bob.boater@example.com'
    end

    it 'creates multiple rows' do
      file_text = <<~TXT
        bob,boater,bob.boater@example.com,sailboat,Bobs Sailboat,20 feet
        sally,sailor,sally.sailor@example.com,sailboat,Sallys Sailboat, 25'
      TXT

      expect { described_class.new(file_text).create! }
        .to change(Customer, :count).from(0).to(2)
                                    .and change(Vehicle, :count).from(0).to(2)
    end
  end

  describe '#normalize_length' do
    it 'does not alter an integer' do
      expect(described_class.new('').normalize_length(5)).to eq 5
    end

    it 'trims off excess characters to return the number of feet as an integer' do
      expect(described_class.new('').normalize_length('5 ft')).to eq 5
    end

    it "trims off the ' to return the number of feet as an integer" do
      expect(described_class.new('').normalize_length("5\'")).to eq 5
    end
  end
end
