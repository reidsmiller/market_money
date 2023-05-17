require 'rails_helper'

RSpec.describe 'MarketVendor Requests' do
  before(:each) do
    @market1 = create(:market)
    @vendor1 = create(:vendor)
  end

  describe 'Create a MarketVendor' do
    let(:valid_params) { {market_id: @market1.id, vendor_id: @vendor1.id} }
    let(:invalid_params) { {market_id: 123123123123, vendor_id: @vendor1.id} }

    it 'happy_path' do
      post '/api/v0/market_vendors', params: valid_params.to_json, headers: { 'Content-Type' => 'application/json' }

      expect(response).to be_successful
      expect(response).to have_http_status(201)

      message = JSON.parse(response.body, symbolize_names: true)

      expect(message[:message]).to eq('Successfully added vendor to market')

      get "/api/v0/markets/#{@market1.id}/vendors"

      vendors = JSON.parse(response.body, symbolize_names: true)

      expect(vendors[:data].count).to eq(1)
    end

    describe 'sad_path #1' do
      it 'market or vendor id is invalid' do
        post '/api/v0/market_vendors', params: invalid_params.to_json, headers: { 'Content-Type' => 'application/json' }

        expect(response).to_not be_successful
        expect(response).to have_http_status(404)

        message = JSON.parse(response.body, symbolize_names: true)

        expect(message[:errors][:detail]).to eq('Validation failed: Market must exist')
      end
    end

    describe 'sad_path #2' do
      it 'passes valid ids but marketvendor with those values already exists' do
        MarketVendor.create!(market_id: @market1.id, vendor_id: @vendor1.id)
        post '/api/v0/market_vendors', params: valid_params.to_json, headers: { 'Content-Type' => 'application/json' }

        expect(response).to_not be_successful
        expect(response).to have_http_status(422)

        message = JSON.parse(response.body, symbolize_names: true)

        expect(message[:errors][:detail]).to eq("Validation failed: Market vendor association between market with market_id=#{@market1.id} and vendor_id=#{@vendor1.id} already exists")
      end
    end
  end

  describe 'delete a marketvendor' do
    describe 'happy path' do
      let(:valid_params) { {market_id: @market1.id, vendor_id: @vendor1.id} }
      let(:invalid_params) { {market_id: 123123123123, vendor_id: @vendor1.id} }

      it 'can destroy a marketvendor' do
        MarketVendor.create!(market_id: @market1.id, vendor_id: @vendor1.id)
        delete '/api/v0/market_vendors', params: valid_params.to_json, headers: { 'Content-Type' => 'application/json' }

        expect(response).to be_successful
        expect(response).to have_http_status(204)

        get "/api/v0/markets/#{@market1.id}/vendors"

        vendors = JSON.parse(response.body, symbolize_names: true)
        expect(vendors[:data].count).to eq(0)
      end
    end

end