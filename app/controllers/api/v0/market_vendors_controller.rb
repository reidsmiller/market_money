class Api::V0::MarketVendorsController < ApplicationController
  rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessable_entity_response
  rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response

  def create
    MarketVendor.create!(market_vendor_params)
    render json: { message: 'Successfully added vendor to market' }, status: 201
  end

  def destroy
    market_vendor = MarketVendor.find_by!(market_vendor_params)
    market_vendor.destroy!
  end

  private

  def market_vendor_params
    params.permit(:market_id, :vendor_id)
  end

  def render_unprocessable_entity_response(exception)
    response_status = MarketVendorValidationSerializer.new(exception).find_status
    render json: { errors: { detail: exception.message } }, status: response_status
  end

  def render_not_found_response(exception)
    render json: MarketVendorNotFoundSerializer.new(exception, market_vendor_params).serialize, status: 404
  end
end