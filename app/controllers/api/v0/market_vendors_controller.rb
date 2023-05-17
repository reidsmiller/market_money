class Api::V0::MarketVendorsController < ApplicationController
  rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessable_entity_response
  
  def create
    MarketVendor.create!(market_vendor_params)
    render json: { message: 'Successfully added vendor to market' }, status: 201
  end

  def destroy
    market_vendor = MarketVendor.find_by(market_vendor_params)
    market_vendor.destroy!
  end

  private

  def market_vendor_params
    params.permit(:market_id, :vendor_id)
  end

  def render_unprocessable_entity_response(exception)
    if exception.message.include?('Market vendor association between')
      render json: { errors: { detail: exception.message } }, status: 422
    else
      render json: { errors: { detail: exception.message } }, status: 404
    end
  end
end