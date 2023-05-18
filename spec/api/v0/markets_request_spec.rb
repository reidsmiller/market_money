require 'rails_helper'

RSpec.describe 'Markets Request' do
  before(:each) do
    @market1 = create(:market, name: 'Market 1', city: 'Denver', state: 'CO')
    @market2 = create(:market, name: 'Market 2', city: 'New York', state: 'NY')
    @market3 = create(:market, name: 'Market 3', city: 'Denver', state: 'CO')

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

  it 'sends a list of all markets' do
    get '/api/v0/markets'

    expect(response).to be_successful
    expect(response).to have_http_status(200)

    markets = JSON.parse(response.body, symbolize_names: true)

    expect(markets[:data].count).to eq(3)

    markets[:data].each do |market|
      expect(market).to have_key(:id)
      expect(market[:id].to_i).to be_an(Integer)

      expect(market[:attributes]).to have_key(:name)
      expect(market[:attributes][:name]).to be_a(String)

      expect(market[:attributes]).to have_key(:street)
      expect(market[:attributes][:street]).to be_a(String)

      expect(market[:attributes]).to have_key(:city)
      expect(market[:attributes][:city]).to be_a(String)

      expect(market[:attributes]).to have_key(:county)
      expect(market[:attributes][:county]).to be_a(String)

      expect(market[:attributes]).to have_key(:state)
      expect(market[:attributes][:state]).to be_a(String)

      expect(market[:attributes]).to have_key(:zip)
      expect(market[:attributes][:zip]).to be_a(String)

      expect(market[:attributes]).to have_key(:lat)
      expect(market[:attributes][:lat]).to be_a(String)

      expect(market[:attributes]).to have_key(:lon)
      expect(market[:attributes][:lon]).to be_a(String)

      expect(market[:attributes]).to have_key(:vendor_count)
      expect(market[:attributes][:vendor_count]).to be_an(Integer)
    end
  end

  describe 'sends a single market by id' do
    it 'happy path' do
      get "/api/v0/markets/#{@market1.id}"

      expect(response).to be_successful
      expect(response).to have_http_status(200)

      market = JSON.parse(response.body, symbolize_names: true)

      expect(market[:data]).to have_key(:id)
      expect(market[:data][:id].to_i).to be_an(Integer)

      expect(market[:data][:attributes]).to have_key(:name)
      expect(market[:data][:attributes][:name]).to be_a(String)

      expect(market[:data][:attributes]).to have_key(:street)
      expect(market[:data][:attributes][:street]).to be_a(String)

      expect(market[:data][:attributes]).to have_key(:city)
      expect(market[:data][:attributes][:city]).to be_a(String)

      expect(market[:data][:attributes]).to have_key(:county)
      expect(market[:data][:attributes][:county]).to be_a(String)

      expect(market[:data][:attributes]).to have_key(:state)
      expect(market[:data][:attributes][:state]).to be_a(String)

      expect(market[:data][:attributes]).to have_key(:zip)
      expect(market[:data][:attributes][:zip]).to be_a(String)

      expect(market[:data][:attributes]).to have_key(:lat)
      expect(market[:data][:attributes][:lat]).to be_a(String)

      expect(market[:data][:attributes]).to have_key(:lon)
      expect(market[:data][:attributes][:lon]).to be_a(String)

      expect(market[:data][:attributes]).to have_key(:vendor_count)
      expect(market[:data][:attributes][:vendor_count]).to be_an(Integer)
    end

    it 'sad path' do
      get '/api/v0/markets/123123123123'

      expect(response).to_not be_successful
      expect(response).to have_http_status(404)

      data = JSON.parse(response.body, symbolize_names: true)

      expect(data[:errors][:detail]).to eq("Couldn't find Market with 'id'=123123123123")
    end
  end

  describe 'Search Markets by state, city, and/or name' do
    describe 'happy path' do
      it 'can return markets with all valid params' do
        valid_params = { city: 'Denver', state: 'CO', name: 'Market 1' }

        get '/api/v0/markets/search', params: valid_params

        expect(response).to be_successful
        expect(response).to have_http_status(200)

        data = JSON.parse(response.body, symbolize_names: true)
        expect(data[:data].count).to eq(1)

        markets = data[:data]
        expect(markets).to be_an(Array)

        expect(markets.first).to have_key(:id)
        expect(markets.first[:id].to_s).to eq(@market1.id)

        expect(markets.first).to have_key(:type)
        expect(markets.first[:type]).to eq('market')

        expect(markets.first).to have_key(:attributes)
        expect(markets.first[:attributes]).to be_a(Hash)

        expect(markets.first[:attributes]).to have_key(:name)
        expect(markets.first[:attributes][:name]).to be_a(String)

        expect(markets.first[:attributes]).to have_key(:street)
        expect(markets.first[:attributes][:street]).to be_a(String)

        expect(markets.first[:attributes]).to have_key(:city)
        expect(markets.first[:attributes][:city]).to be_a(String)

        expect(markets.first[:attributes]).to have_key(:county)
        expect(markets.first[:attributes][:county]).to be_a(String)

        expect(markets.first[:attributes]).to have_key(:state)
        expect(markets.first[:attributes][:state]).to be_a(String)

        expect(markets.first[:attributes]).to have_key(:zip)
        expect(markets.first[:attributes][:zip]).to be_a(String)

        expect(markets.first[:attributes]).to have_key(:lat)
        expect(markets.first[:attributes][:lat]).to be_a(String)

        expect(markets.first[:attributes]).to have_key(:lon)
        expect(markets.first[:attributes][:lon]).to be_a(String)

        expect(markets.first[:attributes]).to have_key(:vendor_count)
        expect(markets.first[:attributes][:vendor_count]).to be_an(Integer)
      end

      it 'can return markets with only 2 valid params' do
        query_params = { name: 'Market 1', state: 'CO' }

        get '/api/v0/markets/search', params: query_params

        expect(response).to be_successful
        expect(response).to have_http_status(200)

        data = JSON.parse(response.body, symbolize_names: true)
        expect(data[:data].count).to eq(1)

        markets = data[:data]
        expect(markets).to be_an(Array)

        expect(markets.first).to have_key(:id)
        expect(markets.first[:id].to_s).to eq(@market1.id)

        expect(markets.first).to have_key(:type)
        expect(markets.first[:type]).to eq('market')

        expect(markets.first).to have_key(:attributes)
        expect(markets.first[:attributes]).to be_a(Hash)

        expect(markets.first[:attributes]).to have_key(:name)
        expect(markets.first[:attributes][:name]).to be_a(String)

        expect(markets.first[:attributes]).to have_key(:street)
        expect(markets.first[:attributes][:street]).to be_a(String)

        expect(markets.first[:attributes]).to have_key(:city)
        expect(markets.first[:attributes][:city]).to be_a(String)

        expect(markets.first[:attributes]).to have_key(:county)
        expect(markets.first[:attributes][:county]).to be_a(String)

        expect(markets.first[:attributes]).to have_key(:state)
        expect(markets.first[:attributes][:state]).to be_a(String)

        expect(markets.first[:attributes]).to have_key(:zip)
        expect(markets.first[:attributes][:zip]).to be_a(String)

        expect(markets.first[:attributes]).to have_key(:lat)
        expect(markets.first[:attributes][:lat]).to be_a(String)

        expect(markets.first[:attributes]).to have_key(:lon)
        expect(markets.first[:attributes][:lon]).to be_a(String)

        expect(markets.first[:attributes]).to have_key(:vendor_count)
        expect(markets.first[:attributes][:vendor_count]).to be_an(Integer)
      end

      it 'can return markets with only 1 valid param' do
        query_params = { name: 'Market 1' }

        get '/api/v0/markets/search', params: query_params

        expect(response).to be_successful
        expect(response).to have_http_status(200)

        data = JSON.parse(response.body, symbolize_names: true)
        expect(data[:data].count).to eq(1)

        markets = data[:data]
        expect(markets).to be_an(Array)

        expect(markets.first).to have_key(:id)
        expect(markets.first[:id].to_s).to eq(@market1.id)

        expect(markets.first).to have_key(:type)
        expect(markets.first[:type]).to eq('market')

        expect(markets.first).to have_key(:attributes)
        expect(markets.first[:attributes]).to be_a(Hash)

        expect(markets.first[:attributes]).to have_key(:name)
        expect(markets.first[:attributes][:name]).to be_a(String)

        expect(markets.first[:attributes]).to have_key(:street)
        expect(markets.first[:attributes][:street]).to be_a(String)

        expect(markets.first[:attributes]).to have_key(:city)
        expect(markets.first[:attributes][:city]).to be_a(String)

        expect(markets.first[:attributes]).to have_key(:county)
        expect(markets.first[:attributes][:county]).to be_a(String)

        expect(markets.first[:attributes]).to have_key(:state)
        expect(markets.first[:attributes][:state]).to be_a(String)

        expect(markets.first[:attributes]).to have_key(:zip)
        expect(markets.first[:attributes][:zip]).to be_a(String)

        expect(markets.first[:attributes]).to have_key(:lat)
        expect(markets.first[:attributes][:lat]).to be_a(String)

        expect(markets.first[:attributes]).to have_key(:lon)
        expect(markets.first[:attributes][:lon]).to be_a(String)

        expect(markets.first[:attributes]).to have_key(:vendor_count)
        expect(markets.first[:attributes][:vendor_count]).to be_an(Integer)
      end
    end

    describe 'sad path' do
      it 'sends error response if only city params are passed' do
        query_params = { city: 'Denver'}

        get '/api/v0/markets/search', params: query_params

        expect(response).to_not be_successful
        expect(response).to have_http_status(422)

        data = JSON.parse(response.body, symbolize_names: true)
        expect(data[:errors][:detail]).to eq('Invalid set of parameters. Please provide a valid set of parameters to peform a search with this endpoint.')
      end

      it 'sends error response if only city and name params are passed' do
        query_params = { city: 'Denver', name: 'Market 1' }

        get '/api/v0/markets/search', params: query_params

        expect(response).to_not be_successful
        expect(response).to have_http_status(422)

        data = JSON.parse(response.body, symbolize_names: true)
        expect(data[:errors][:detail]).to eq('Invalid set of parameters. Please provide a valid set of parameters to peform a search with this endpoint.')
      end

      it 'returns empty array if valid params are searched with no found markets' do
        query_params = { city: 'Denver', state: 'NY', name: 'Market 1' }

        get "/api/v0/markets/search", params: query_params

        expect(response).to be_successful
        expect(response.status).to eq(200)

        data = JSON.parse(response.body, symbolize_names: true)
        expect(data).to have_key(:data)

        markets = data[:data]
        expect(markets).to be_an(Array)
        expect(markets.count).to eq(0)
      end
    end
  end
end