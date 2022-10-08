class PricePerDistance < ApplicationRecord
  validates :min_distance, :max_distance, :price, presence: true 
  validates :min_distance, numericality: {greater_than_or_equal_to: 1}
  validates :max_distance, numericality: {less_than: 4_400}

end
