# frozen_string_literal: true

class Vehicle < ApplicationRecord
  include PGEnum(vehicle_type: %w[campervan sailboat motorboat RV bicycle])
  belongs_to :customer
  validates :name, presence: true
  validates :vehicle_type, presence: true
  validates :length_feet, presence: true, numericality: true
end
