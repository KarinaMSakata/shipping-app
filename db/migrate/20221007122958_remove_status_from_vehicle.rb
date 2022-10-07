class RemoveStatusFromVehicle < ActiveRecord::Migration[7.0]
  def change
    remove_column :vehicles, :status, :integer
  end
end
