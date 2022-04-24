# frozen_string_literal: true

class SortedCustomers
  attr_reader :sort_column

  def initialize(sort_column:, original_sort_direction:)
    @sort_column = sort_column
    @original_sort_direction = original_sort_direction
  end

  def customers
    @_customers ||= case sort_column
                    when :full_name
                      base_relation.order(first_name: sort_direction, last_name: sort_direction)
                    when :vehicle_type
                      base_relation.order("lower(vehicle_type::varchar) #{sort_direction}")
                    else
                      base_relation
                    end
  end

  def sort_direction
    @_sort_direction ||= original_sort_direction == :desc ? :desc : :asc
  end

  private

  attr_reader :original_sort_direction

  def base_relation
    Customer.joins(:vehicle).includes(:vehicle)
  end
end
