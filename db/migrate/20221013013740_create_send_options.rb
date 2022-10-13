class CreateSendOptions < ActiveRecord::Migration[7.0]
  def change
    create_table :send_options do |t|
      t.references :mode_of_transport, null: false, foreign_key: true
      t.references :vehicle, null: false, foreign_key: true
      t.references :create_order_of_service, null: false, foreign_key: true

      t.timestamps
    end
  end
end
