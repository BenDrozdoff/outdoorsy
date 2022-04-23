# frozen_string_literal: true

class Customer < ApplicationRecord
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true, uniqueness: true
  has_one :vehicle, dependent: :destroy

  def full_name
    [first_name, last_name].join(' ')
  end
end
