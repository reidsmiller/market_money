class MarketVendorValidationSerializer
  def initialize(exception)
    @exception = exception
    @status = nil
  end

  def find_status
    @status = @exception.message.include?('Market vendor association between') ? 422 : 404
  end
end