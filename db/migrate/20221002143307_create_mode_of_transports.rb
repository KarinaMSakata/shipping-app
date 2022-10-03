class CreateModeOfTransports < ActiveRecord::Migration[7.0]
  def change
    create_table :mode_of_transports do |t|
      t.string :name
      t.integer :max_distance
      t.integer :min_distance
      t.integer :max_weight
      t.integer :min_weight
      t.integer :fixed_rate

      t.timestamps
    end
  end
end
