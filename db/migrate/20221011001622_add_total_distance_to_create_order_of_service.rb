class AddTotalDistanceToCreateOrderOfService < ActiveRecord::Migration[7.0]
  def change
    add_column :create_order_of_services, :total_distance, :integer
  end
end
