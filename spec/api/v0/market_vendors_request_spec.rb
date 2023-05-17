require 'rails_helper'

RSpec.describe 'MarketVendor Requests' do
  before(:each) do
    @market1 = create(:market)
    @market2 = create(:market)
    @market3 = create(:market)

    @vendor1 = create(:vendor)
    @vendor2 = create(:vendor)
    @vendor3 = create(:vendor)
    @vendor4 = create(:vendor)
    @vendor5 = create(:vendor)
  end

  describe 'Create a MarketVendor' do
    let(:valid_params) { {market_id: @market1.id, vendor_id: @vendor1} }

    it 'happy_path' do
      post '/api/v0/market_vendors', params: valid_params.to_json, headers: { 'Content-Type' => 'application/json' }

      expect(response).to be_successful
      expect(response).to have_http_status(201)

      message = JSON.parse(response.body, symbolize_names: true)

      expect(message).to eq('Successfully added vendor to market')
    end
  end
end