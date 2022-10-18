class AddCreateOrderOfServiceToFeedback < ActiveRecord::Migration[7.0]
  def change
    add_reference :feedbacks, :create_order_of_service, null: false, foreign_key: true
  end
end
