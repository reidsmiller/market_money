class MarketVendor < ApplicationRecord
  validate :unique_market_vendor

  belongs_to :market
  belongs_to :vendor

  def unique_market_vendor
    market_vendor_search = MarketVendor.find_by(market_id: market_id, vendor_id: vendor_id)
    if market_vendor_search != nil
      errors.add(:base, "Market vendor association between market with market_id=#{market_id} and vendor_id=#{vendor_id} already exists")
    end
  end
end