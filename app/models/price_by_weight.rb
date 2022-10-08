class PriceByWeight < ApplicationRecord
  validates :min_weight, :max_weight, :price_per_km, presence: true
  validates :min_weight, numericality: {greater_than_or_equal_to: 1}
  validates :max_weight, numericality: {less_than_or_equal_to: 10000}

end
