require 'rails_helper'

RSpec.describe 'Vendor Requests' do
  before(:each) do
    @market1 = create(:market)
    @market2 = create(:market)
    @market3 = create(:market)

    @vendor1 = create(:vendor)
    @vendor2 = create(:vendor)
    @vendor3 = create(:vendor)
    @vendor4 = create(:vendor)
    @vendor5 = create(:vendor)

    MarketVendor.create!(market_id: @market1.id, vendor_id: @vendor1.id)
    MarketVendor.create!(market_id: @market1.id, vendor_id: @vendor2.id)
    MarketVendor.create!(market_id: @market1.id, vendor_id: @vendor3.id)
    MarketVendor.create!(market_id: @market2.id, vendor_id: @vendor1.id)
    MarketVendor.create!(market_id: @market2.id, vendor_id: @vendor2.id)
    MarketVendor.create!(market_id: @market3.id, vendor_id: @vendor4.id)
    MarketVendor.create!(market_id: @market3.id, vendor_id: @vendor1.id)
    MarketVendor.create!(market_id: @market3.id, vendor_id: @vendor5.id)
  end

  describe 'sends a single vendor' do
    it 'happy path' do
      get "/api/v0/vendors/#{@vendor1.id}"

      expect(response).to be_successful

      vendor = JSON.parse(response.body, symbolize_names: true)

      expect(vendor[:data]).to have_key(:id)
      expect(vendor[:data][:id].to_i).to be_an(Integer)

      expect(vendor[:data][:attributes]).to have_key(:name)
      expect(vendor[:data][:attributes][:name]).to be_a(String)

      expect(vendor[:data][:attributes]).to have_key(:description)
      expect(vendor[:data][:attributes][:description]).to be_a(String)

      expect(vendor[:data][:attributes]).to have_key(:contact_name)
      expect(vendor[:data][:attributes][:contact_name]).to be_a(String)

      expect(vendor[:data][:attributes]).to have_key(:contact_phone)
      expect(vendor[:data][:attributes][:contact_phone]).to be_a(String)

      expect(vendor[:data][:attributes]).to have_key(:credit_accepted)
      expect(vendor[:data][:attributes][:credit_accepted]).to be_a(TrueClass).or be_a(FalseClass)
    end

    it 'sad path' do
      get '/api/v0/vendors/123123123123'

      expect(response).to_not be_successful

      data = JSON.parse(response.body, symbolize_names: true)

      expect(data[:errors]).to eq("Couldn't find Vendor with 'id'=123123123123")
    end
  end
end