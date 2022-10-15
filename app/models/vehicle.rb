class Vehicle < ApplicationRecord
  has_many :send_options
  
  enum status: {in_maintenance: 0, in_operation: 2 }
  validates :sort, :brand, :model, :identification, :year_manufacture, :max_load, presence: true
  validates :identification, length: {is: 7}
  validates :year_manufacture, length: {is: 4}
  validates :max_load, numericality: {greater_than: 0}
  validates :identification, uniqueness: true

  def description 
    "#{sort} #{brand} | #{model}"
  end
end
