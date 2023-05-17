class Api::V0::VendorsController < ApplicationController
  def index
    market = Market.find(params[:market_id])
    vendors = market.vendors
    render json: VendorSerializer.new(vendors)
  end

  def show
    render json: VendorSerializer.new(Vendor.find(params[:id]))
  end

  def create
    vendor = Vendor.new(vendor_params)
    if vendor.save
      render json: VendorSerializer.new(vendor), status: :created
    else
      render json: { errors: { detail: "Validation failed: #{vendor.errors.full_messages.join(', ')}" } }, status: :unprocessable_entity
    end
  end

  def update
    if Vendor.update(vendor_params)
      render json: VendorSerializer.new(Vendor.find(params[:id])), status: :accepted
    else
      render json: { errors: { detail: "Validation failed: #{vendor.errors.full_messages.join(', ')}" } }, status: :unprocessable_entity
    end
  end

  def destroy

  end

  private

  def vendor_params
    params.require(:body).permit(:name, :description, :contact_name, :contact_phone, :credit_accepted)
  end
end