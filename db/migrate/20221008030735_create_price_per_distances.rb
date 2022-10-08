class CreatePricePerDistances < ActiveRecord::Migration[7.0]
  def change
    create_table :price_per_distances do |t|
      t.integer :min_distance
      t.integer :max_distance
      t.decimal :price

      t.timestamps
    end
  end
end
