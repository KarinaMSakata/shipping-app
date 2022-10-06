class Vehicle < ApplicationRecord
  validates :sort, :brand, :model, :identification, :year_manufacture, :max_load, presence: true
  validates :identification, length: {is: 7}
  validates :year_manufacture, length: {is: 4}
  validates :max_load, numericality: {greater_than: 0}
end
