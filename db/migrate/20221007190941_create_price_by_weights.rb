class CreatePriceByWeights < ActiveRecord::Migration[7.0]
  def change
    create_table :price_by_weights do |t|
      t.integer :min_weight
      t.integer :max_weight
      t.decimal :price_per_km

      t.timestamps
    end
  end
end
