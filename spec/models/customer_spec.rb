# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Customer do
  it { is_expected.to have_one :vehicle }
  describe 'validations' do
    subject { build :customer }
    it { is_expected.to validate_presence_of :first_name }
    it { is_expected.to validate_presence_of :last_name }
    it { is_expected.to validate_presence_of :email }
    it { is_expected.to validate_uniqueness_of :email }
  end

  describe 'full name' do
    it 'combines the first and last name' do
      customer = build :customer, first_name: 'Hello', last_name: 'World'
      expect(customer.full_name).to eq 'Hello World'
    end
  end
end
