require 'rails_helper'

RSpec.describe Vendor, type: :model do
  describe 'relationships' do
    it { should have_many(:market_vendors) }
    it { should have_many(:markets).through(:market_vendors) }
  end

  describe 'validations' do
    it { should validate_presence_of :name }
    it { should validate_presence_of :description }
    it { should validate_presence_of :contact_name }
    it { should validate_presence_of :contact_phone }
    it 'is expected to validate that :credit_accepted cannot be empty' do
      vendor1 = Vendor.new(
        'name': 'Buzzy Bees',
        'description': 'local honey and wax products',
        'contact_name': 'Berly Couwer',
        'contact_phone': '8389928383',
        'credit_accepted': false
      )

      vendor2 = Vendor.new(
        'name': 'Buzzy Bees',
        'description': 'local honey and wax products',
        'contact_name': 'Berly Couwer',
        'contact_phone': '8389928383',
        'credit_accepted': ''
      )
      expect(vendor1.save).to be(true)
      expect(vendor2.save).to be(false)
    end
  end
end