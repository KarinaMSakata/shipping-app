class CreateDeliveryTimes < ActiveRecord::Migration[7.0]
  def change
    create_table :delivery_times do |t|
      t.integer :origin
      t.integer :destination
      t.integer :hours

      t.timestamps
    end
  end
end
