class AddHourToDeliveryTime < ActiveRecord::Migration[7.0]
  def change
    add_column :delivery_times, :hours, :time
  end
end
