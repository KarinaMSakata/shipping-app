class RemoveHoursFromDeliveryTime < ActiveRecord::Migration[7.0]
  def change
    remove_column :delivery_times, :hours, :integer
  end
end
