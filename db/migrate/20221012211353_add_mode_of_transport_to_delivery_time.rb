class AddModeOfTransportToDeliveryTime < ActiveRecord::Migration[7.0]
  def change
    add_reference :delivery_times, :mode_of_transport, null: false, foreign_key: true
  end
end
