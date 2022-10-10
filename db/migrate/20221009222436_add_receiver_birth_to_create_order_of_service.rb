class AddReceiverBirthToCreateOrderOfService < ActiveRecord::Migration[7.0]
  def change
    add_column :create_order_of_services, :receiver_birth, :date
  end
end
