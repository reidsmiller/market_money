class Api::V0::VendorsController < ApplicationController
  rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessable_entity_response

  def index
    market = Market.find(params[:market_id])
    vendors = market.vendors
    render json: VendorSerializer.new(vendors)
  end

  def show
    render json: VendorSerializer.new(Vendor.find(params[:id]))
  end

  def create
    vendor = Vendor.create!(vendor_params)
    render json: VendorSerializer.new(vendor), status: 201
  end

  def update
    vendor = Vendor.find(params[:id])
    vendor.update!(vendor_params)
    render json: VendorSerializer.new(vendor), status: 200
  end

  def destroy
    vendor = Vendor.find(params[:id])
    vendor.market_vendors.destroy_all
    vendor.destroy!
  end

  private

  def vendor_params
    params.permit(:name, :description, :contact_name, :contact_phone, :credit_accepted)
  end

  def render_unprocessable_entity_response(exception)
    render json: { errors: { detail: exception.message } }, status: 400
  end
end