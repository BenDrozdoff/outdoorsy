# frozen_string_literal: true

class CustomerImport
  attr_reader :file_text

  RECOGNIZED_DELIMITERS = [',', '|'].freeze
  REQUIRED_COLUMN_ORDER = %i[first_name last_name email vehicle_type vehicle_name vehicle_length].freeze
  LENGTH_PARSING_REGEX = /\d+/

  UnparseableFile = Class.new(StandardError)

  def initialize(file_text)
    @file_text = file_text.strip
  end

  def create!
    ActiveRecord::Base.transaction do
      normalized_rows.each do |normalized_row|
        customer = upsert_customer!(normalized_row)
        create_vehicle!(customer: customer, normalized_row: normalized_row)
      end
    end
  end

  def normalize_length(length)
    return length if length.is_a? Integer

    return LENGTH_PARSING_REGEX.match(length)[0].to_i if LENGTH_PARSING_REGEX.match?(length)
  end

  private

  def upsert_customer!(normalized_row)
    Customer.find_or_initialize_by(email: normalized_row[:email]).tap do |customer|
      customer.first_name = normalized_row[:first_name]
      customer.last_name = normalized_row[:last_name]
      customer.save!
    end
  end

  def create_vehicle!(customer:, normalized_row:)
    Vehicle.find_or_create_by!(
      customer: customer,
      name: normalized_row[:vehicle_name],
      vehicle_type: normalized_row[:vehicle_type],
      length_feet: normalized_row[:vehicle_length]
    )
  end

  def original_rows
    @_original_rows ||= file_text.split(/\n/)
  end

  def parsed_rows
    original_rows.map do |original_row|
      Hash[REQUIRED_COLUMN_ORDER.zip(original_row.split(file_delimiter))]
    end
  end

  def normalized_rows
    parsed_rows.each do |parsed_row|
      parsed_row[:vehicle_length] = normalize_length(parsed_row[:vehicle_length])
    end
  end

  def file_delimiter
    return @_delimiter if @_delimiter

    RECOGNIZED_DELIMITERS.each do |delimiter|
      attempted_parsed_row = original_rows.first.split(delimiter)

      next unless attempted_parsed_row.length == REQUIRED_COLUMN_ORDER.length

      @_delimiter = delimiter

      return @_delimiter
    end

    raise UnparseableFile, "Must include following columns: #{REQUIRED_COLUMN_ORDER.join(' ')}"
  end
end
