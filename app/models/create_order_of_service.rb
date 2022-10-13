class CreateOrderOfService < ApplicationRecord
  has_many :send_options
  enum status: {pending: 0, initiated: 2}
  validates :output_address, :output_city, :output_state, :product_code, :cargo_weight, 
            :receiver_address, :receiver_city, :receiver_state, :receiver_name, :receiver_cpf, 
            :receiver_birth, :total_distance, :code, presence: true
  validates :cargo_weight, numericality: {less_than_or_equal_to: 10000}
  validates :receiver_cpf, numericality: true
  validates :total_distance, numericality: {less_than: 4400}
  validates :product_code, length: {maximum: 18}
  validates :receiver_cpf, length: {is: 11}

  before_validation :generate_code, on: :create

  private

  def generate_code
    self.code = SecureRandom.alphanumeric(15).upcase
  end
end
