class CreateVehicles < ActiveRecord::Migration[7.0]
  def change
    create_table :vehicles do |t|
      t.string :type
      t.string :brand
      t.string :model
      t.string :identification
      t.string :year_manufacture
      t.integer :max_load
      t.integer :status

      t.timestamps
    end
  end
end
