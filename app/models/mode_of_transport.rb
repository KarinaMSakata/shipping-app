class ModeOfTransport < ApplicationRecord
  enum status: {disable: 0, activated: 2}
  validates :name, :min_distance, :max_distance, :min_weight, :max_weight, :fixed_rate,  presence: true
  validates :min_distance, :min_weight, :fixed_rate, numericality: {greater_than: 0}
  validates :max_distance, numericality: {less_than: 4_400}
  validates :max_weight, numericality: {less_than_or_equal_to: 10000}
end
