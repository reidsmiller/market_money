class Api::V0::MarketVendorsController < ApplicationController
  rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessable_entity_response
  
  def create
    MarketVendor.create!(market_vendor_params)
    render json: { message: 'Successfully added vendor to market' }, status: 201
  end

  def destroy
  end

  private

  def market_vendor_params
    params.permit(:market_id, :vendor_id)
  end

  def render_unprocessable_entity_response(exception)
    render json: { errors: { detail: "Validation failed: #{exception.record.errors.full_messages.join(', ')}" } }, status: 404
  end
end