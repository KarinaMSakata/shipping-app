class AddHoursIntegerToDeliveryTime < ActiveRecord::Migration[7.0]
  def change
    add_column :delivery_times, :hours, :integer
  end
end
