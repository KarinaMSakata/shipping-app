class PriceByWeight < ApplicationRecord
  validates :min_weight, :max_weight, :price_per_km, presence: true
end
