# frozen_string_literal: true

class CustomerImportsController < ApplicationController
  before_action :validate_filetype

  InvalidFileType = Class.new(StandardError)

  rescue_from ActionController::ParameterMissing, with: :bad_request
  rescue_from InvalidFileType, with: :unprocessable_entity

  VALID_MIME_TYPES = ['text/plain'].freeze

  def create
    CustomerImport.new(file_text).create!
  rescue ActiveRecord::RecordInvalid
    flash[:error] = 'Invalid data in file. Customers not created'
  ensure
    redirect_to customers_path
  end

  private

  def validate_filetype
    raise InvalidFileType unless VALID_MIME_TYPES.include? file_param.content_type
  end

  def file_text
    file_param.read
  end

  def file_param
    params.require(:file)
  end
end
