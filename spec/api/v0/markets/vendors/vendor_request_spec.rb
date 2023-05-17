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

  describe 'sends a list of all vendors for a particular market' do
    it 'happy path' do
      get "/api/v0/markets/#{@market1.id}/vendors"

      expect(response).to be_successful

      vendors = JSON.parse(response.body, symbolize_names: true)

      expect(vendors[:data].count).to eq(3)

      vendors[:data].each do |vendor|
        expect(vendor).to have_key(:id)
        expect(vendor[:id].to_i).to be_an(Integer)

        expect(vendor[:attributes]).to have_key(:name)
        expect(vendor[:attributes][:name]).to be_a(String)

        expect(vendor[:attributes]).to have_key(:description)
        expect(vendor[:attributes][:description]).to be_a(String)

        expect(vendor[:attributes]).to have_key(:contact_name)
        expect(vendor[:attributes][:contact_name]).to be_a(String)

        expect(vendor[:attributes]).to have_key(:contact_phone)
        expect(vendor[:attributes][:contact_phone]).to be_a(String)

        expect(vendor[:attributes]).to have_key(:credit_accepted)
        expect(vendor[:attributes][:credit_accepted]).to be_a(TrueClass).or be_a(FalseClass)
      end
    end

    it 'sad path' do
      get '/api/v0/markets/123123123123/vendors'

      expect(response).to_not be_successful
      expect(response).to have_http_status(404)

      data = JSON.parse(response.body, symbolize_names: true)
      expect(data[:errors][:detail]).to eq("Couldn't find Market with 'id'=123123123123")
    end
  end
end