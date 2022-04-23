# frozen_string_literal: true

class CreateVehicles < ActiveRecord::Migration[6.1]
  def change
    create_enum :vehicle_type, %w[campervan sailboat motorboat RV bicycle]

    create_table :vehicles do |t|
      t.enum :vehicle_type, as: :vehicle_type, null: false
      t.string :name, null: false
      t.integer :length_feet, null: false
      t.references :customer, foreign_key: true

      t.timestamps
    end
  end
end
