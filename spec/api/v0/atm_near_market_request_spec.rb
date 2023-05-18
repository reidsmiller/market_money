require 'rails_helper'

RSpec.describe 'AtmNearMarket API' do
  describe 'finds atms' do
    before(:each) do
      @market = Market.create!(name: 'Union Station Farmers Market', address_line_1: '1701 Wynkoop St', city: 'Denver', state: 'CO', zip: '80202', lat: 39.752986, lon: -104.998399)
    end

    describe 'happy path' do
      it 'returns all atms near a market from closest to farthest' do
        get "/api/v0/markets/#{@market[:id]}/nearest_atms"

        expect(response).to be_successful
        expect(response).to have_http_status(200)

        data = JSON.parse(response.body, symbolize_names: true)

        expect(data).to be_a(Hash)
        expect(data[:data]).to be_an(Array)

        atms = data[:data]
        atms.each do |atm|
          expect(atm).to have_key(:id)

          expect(atm).to have_key(:type)
          expect(atm[:type]).to be_a(String)

          expect(atm).to have_key(:attributes)
          expect(atm[:attributes]).to be_a(Hash)

          expect(atm[:attributes]).to have_key(:name)
          expect(atm[:attributes][:name]).to be_a(String)

          expect(atm[:attributes]).to have_key(:address)
          expect(atm[:attributes][:address]).to be_a(String)

          expect(atm[:attributes]).to have_key(:lat)
          expect(atm[:attributes][:lat]).to be_a(Float)

          expect(atm[:attributes]).to have_key(:lon)
          expect(atm[:attributes][:lon]).to be_a(Float)

          expect(atm[:attributes]).to have_key(:distance)
          expect(atm[:attributes][:distance]).to be_a(Float)
        end

        if i < atms.length - 1
          expect(atms[i][:attributes][:distance]).to be < (atms[(i+1)][:attributes][:distance])
        end
      end
    end
  end
end