class AddDimensionsToCreateOrderOfService < ActiveRecord::Migration[7.0]
  def change
    add_column :create_order_of_services, :height, :integer
    add_column :create_order_of_services, :width, :integer
    add_column :create_order_of_services, :depth, :integer
  end
end
