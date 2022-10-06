class RemoveTypeFromVehicle < ActiveRecord::Migration[7.0]
  def change
    remove_column :vehicles, :type, :string
  end
end
