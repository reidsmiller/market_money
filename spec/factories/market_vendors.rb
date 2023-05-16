FactoryBot.define do
  factory :market_vendor do
    market_id { Faker::MarketVendor.market_id }
    vendor_id { Faker::MarketVendor.invoice_id }
  end
end