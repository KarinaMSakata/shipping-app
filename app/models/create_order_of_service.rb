class CreateOrderOfService < ApplicationRecord
  validates :output_address, :output_city, :output_state, :product_code, :cargo_weight, 
            :receiver_address, :receiver_city, :receiver_state, :receiver_name, :receiver_cpf, 
            :receiver_birth, presence: true
end
