class SendOption < ApplicationRecord
  belongs_to :mode_of_transport
  belongs_to :vehicle
  belongs_to :create_order_of_service
  
  validates :vehicle_id, presence: true
end
