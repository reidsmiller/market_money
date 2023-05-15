require 'rails_helper'

RSpec.describe Vendor, type: :model do
  describe 'relationships' do
    it { should have_many(:market_vendors) }
    it { should have_many(:vendors).through(:market_vendors) }
  end
end