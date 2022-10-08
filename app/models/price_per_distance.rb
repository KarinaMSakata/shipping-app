class PricePerDistance < ApplicationRecord
  validates :min_distance, :max_distance, :price, presence: true 
end
