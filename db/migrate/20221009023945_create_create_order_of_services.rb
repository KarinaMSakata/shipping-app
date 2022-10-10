class CreateCreateOrderOfServices < ActiveRecord::Migration[7.0]
  def change
    create_table :create_order_of_services do |t|
      t.string :output_address
      t.string :output_city
      t.string :output_state
      t.string :product_code
      t.integer :cargo_weight
      t.string :receiver_address
      t.string :receiver_city
      t.string :receiver_state
      t.string :receiver_name
      t.string :receiver_cpf
      t.string :receiver_bith

      t.timestamps
    end
  end
end
