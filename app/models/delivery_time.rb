class DeliveryTime < ApplicationRecord
  validates :origin, :destination, :hours, presence: true
  validates :origin, numericality: {greater_than_or_equal_to: 1}
  validates :destination, numericality: {less_than: 4400}
  validates :hours, numericality: {greater_than_or_equal_to: 24}

end
