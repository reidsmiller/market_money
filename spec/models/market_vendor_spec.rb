require 'rails_helper'

RSpec.describe MarketVendor, type: :model do
  describe 'relationships' do
    it { should belong_to(:market) }
    it { should belong_to(:vendor) }
  end

  describe 'validations' do
    it 'validates that any creation is a unique marketvendor' do
      market1 = create(:market)
      vendor1 = create(:vendor)

      valid = MarketVendor.new(market_id: market1.id, vendor_id: vendor1.id)
      expect(valid.save).to be(true)

      valid.save

      invalid = MarketVendor.new(market_id: market1.id, vendor_id: vendor1.id)
      expect(invalid.save).to be(false)
    end
  end
end