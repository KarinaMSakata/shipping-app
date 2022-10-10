class RemoveReceiverBithFromCreateOrderOfService < ActiveRecord::Migration[7.0]
  def change
    remove_column :create_order_of_services, :receiver_bith, :string
  end
end
