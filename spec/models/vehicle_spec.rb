# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Vehicle do
  it { is_expected.to belong_to :customer }
  describe 'validations' do
    it { is_expected.to validate_presence_of :vehicle_type }
    it { is_expected.to validate_presence_of :name }
    it { is_expected.to validate_presence_of :length_feet }
    it { is_expected.to validate_numericality_of :length_feet }
  end
end
