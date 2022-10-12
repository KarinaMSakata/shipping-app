class AddModeOfTransportToPricePerDistance < ActiveRecord::Migration[7.0]
  def change
    add_reference :price_per_distances, :mode_of_transport, null: false, foreign_key: true
  end
end
