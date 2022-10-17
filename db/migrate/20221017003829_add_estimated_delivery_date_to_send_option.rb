class AddEstimatedDeliveryDateToSendOption < ActiveRecord::Migration[7.0]
  def change
    add_column :send_options, :estimated_delivery_date, :date
  end
end
