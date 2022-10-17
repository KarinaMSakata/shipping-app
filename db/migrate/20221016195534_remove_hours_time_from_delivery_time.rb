class RemoveHoursTimeFromDeliveryTime < ActiveRecord::Migration[7.0]
  def change
    remove_column :delivery_times, :hours, :time
  end
end
