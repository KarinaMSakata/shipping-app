class ModeOfTransport < ApplicationRecord
  has_many :price_by_weights
  has_many :price_per_distances
  has_many :delivery_times
  has_many :send_options
  
  enum status: {disable: 0, activated: 2}
  validates :name, :min_distance, :max_distance, :min_weight, :max_weight, :fixed_rate,  presence: true
  validates :fixed_rate, numericality: {greater_than: 0}
  validates :min_distance, :min_weight, numericality: {greater_than_or_equal_to: 1}
  validates :max_distance, numericality: {less_than: 4_400}
  validates :max_weight, numericality: {less_than_or_equal_to: 10000}

  def calcula_taxas
    preço_km = (price_by_weights.last.price_per_km)*(send_options.last.create_order_of_service.total_distance)
    preço_distancia = (price_per_distances.last.price)
    tx_fixa = (fixed_rate)
    total = preço_km + preço_distancia + tx_fixa
    total
  end

end
