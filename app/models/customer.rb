# frozen_string_literal: true

class Customer < ApplicationRecord
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true, uniqueness: true
  validates_format_of :email, with: /\A[^@\s]+@([^@\s]+\.)+[^@\s]+\z/

  has_one :vehicle, dependent: :destroy

  delegate :name, :length_feet, to: :vehicle, prefix: true
  delegate :vehicle_type, to: :vehicle

  def full_name
    [first_name, last_name].join(' ')
  end
end
