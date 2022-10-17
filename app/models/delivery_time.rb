class DeliveryTime < ApplicationRecord
  belongs_to :mode_of_transport
  validates :origin, :destination, :hours, presence: true
  validates :origin, numericality: {greater_than_or_equal_to: 1}
  validates :destination, numericality: {less_than: 4400}

end
