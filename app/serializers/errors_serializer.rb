class ErrorsSerializer
  attr_reader :record

  def initialize(record)
    @record = record
  end

  def serialize
    record.errors.details.map do |field, details|
      details.map do |error_details|
        ErrorSerializer.new(record, field, error_details).serialize
      end
    end.flatten
  end
end