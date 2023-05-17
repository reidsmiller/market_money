class Vendor < ApplicationRecord
  validates :name, presence: true
  validates :description, presence: true
  validates :contact_name, presence: true
  validates :contact_phone, presence: true
  validate :validate_presence_of_credit_accepted
  has_many :market_vendors
  has_many :markets, through: :market_vendors

  def validate_presence_of_credit_accepted
    if credit_accepted != true && credit_accepted != false
      errors.add(:credit_accepted, "can't be blank")
    end
  end
end