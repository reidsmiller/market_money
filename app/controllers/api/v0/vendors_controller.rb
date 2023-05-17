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
      render json: { errors: { detail: "Validation failed: #{vendor.errors.full_messages.join(', ')}" } }, status: 400
    end
  end

  def update
    vendor = Vendor.find(params[:id])
    if vendor.update(vendor_params)
      render json: VendorSerializer.new(vendor), status: :accepted
    else
      render json: { errors: { detail: "Validation failed: #{vendor.errors.full_messages.join(', ')}" } }, status: :unprocessable_entity
    end
  end

  def destroy
    vendor = Vendor.find(params[:id])
    vendor.market_vendors.destroy_all
    if vendor.destroy
      head :no_content
    else
      render json: { errors: { detail: "Couldn't find Vendor with 'id'=#{params[:id]}" } }, status: :unprocessable_entity
    end
  end

  private

  def vendor_params
    params.permit(:name, :description, :contact_name, :contact_phone, :credit_accepted)
  end
end