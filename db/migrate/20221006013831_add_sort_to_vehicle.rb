class AddSortToVehicle < ActiveRecord::Migration[7.0]
  def change
    add_column :vehicles, :sort, :string
  end
end
