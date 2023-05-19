class MarketVendorNotFoundSerializer
  def initialize(exception, market_vendor_params)
    @exception = exception
    @params = market_vendor_params
  end

  def serialize
    if @exception.message.include?("Couldn't find MarketVendor with")
      { errors: { detail: "No MarketVendor with market_id=#{@params[:market_id]} AND vendor_id=#{@params[:vendor_id]}" } }
    else
      { errors: { detail: @exception.message } }
    end
  end
end