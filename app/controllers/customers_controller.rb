# frozen_string_literal: true

class CustomersController < ApplicationController
  def index
    @sorted_customers = SortedCustomers.new(sort_column: sort_column, original_sort_direction: sort_direction)
  end

  private

  def sort_direction
    params.permit(:sort_direction)[:sort_direction]&.to_sym
  end

  def sort_column
    params.permit(:sort_column)[:sort_column]&.to_sym
  end
end
