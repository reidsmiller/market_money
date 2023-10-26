# README
This is an e-commerce API that allows access to market and vendor information including revenue and items sold statistics for markets. Available endpoints are detailed below. Currently, this API is not deployed, but can be run on localhost:3000 and accessed via Postman. 

* Ruby version
 `ruby 3.1.1`
 `rails 7.0.4`
 
* System dependencies
  - Testing Gems
    - `pry`
    - `rspec-rails`
    - `factory_bot_rails`
    - `faker`
    - `shoulda-matchers`
    - `simplecov`
    - `capybara`
* Configuration
  - fork and/or clone this repo
  - `bundle install`
* Database creation and initialization
  - `rails db:{drop,create,migrate,seed}`
  - `rails db:schema:dump`
* How to run the test suite
  - `bundle exec rspec`
* Endpoints
  - all endpoints begin with '/api/v0'
  - Market endpoints
    - GET /markets
      - returns a list of all markets
    - GET /markets/:id
      - returns one market by ID
    - GET /markets/:market_id/vendors
      - returns a list of vendors for given market by market ID
    - GET /markets/search
      - returns list of markets by three parameters: name, city, state
      - must include state parameter if city parameter is used
    - GET /martkets/:id/nearest_atms
      - returns all atms near a market from closest to farthest
  - Vendor endpoints
    - POST /vendors
      - create a new vendor
      - required attributes: name, description, contact_name, contact_phone, credit_accepted
    - GET /vendors/:id
      - return a single vendor by ID
    - PATCH /vendors/:id
      - updates a single item by ID
    - DELETE /vendors/:id
      - destroys a single item by ID
  - MarketVendor endpoints
    - POST /market_vendors
      - creates an association between a vendor and market
      - required parameters: vendor_id, market_id
    - DELETE /market_vendors
      - deletes an assoiciation between a vendor and market
      - required parameters: vendor_id, market_id
 
