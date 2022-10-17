class CreateDelays < ActiveRecord::Migration[7.0]
  def change
    create_table :delays do |t|
      t.string :description

      t.timestamps
    end
  end
end
