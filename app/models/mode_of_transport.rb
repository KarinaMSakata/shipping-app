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

def price_weight(create_order_of_service)
  price_by_weights.each do |p|
    if p.min_weight <= create_order_of_service.cargo_weight && p.max_weight >= create_order_of_service.cargo_weight
      return (p.price_per_km)*(create_order_of_service.total_distance)
    else
      return 'Não há valor disponível'
    end
  end
end

def price_distance(create_order_of_service)
  price_per_distances.each do |d|
    if d.min_distance <= create_order_of_service.total_distance && d.max_distance >= create_order_of_service.total_distance
      return (d.price)
    else
      return 'Não há valor disponível'
    end
  end
end

def delivery_time(create_order_of_service)
  delivery_times.each do |dt|
    if dt.origin <= create_order_of_service.total_distance && dt.destination >= create_order_of_service.total_distance
      return (dt.hours)
    end
  end
end



end
