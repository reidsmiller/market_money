class MarketVendorNotFoundSerializer
  def initialize(exception, market_vendor_params)
    @exception = exception
    @params = market_vendor_params
  end

  def serialize
      { errors: { detail: "No MarketVendor with market_id=#{@params[:market_id]} AND vendor_id=#{@params[:vendor_id]}" } }
  end
end