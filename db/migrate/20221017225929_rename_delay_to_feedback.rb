class RenameDelayToFeedback < ActiveRecord::Migration[7.0]
  def self.up
    rename_table :delays, :feedbacks 
  end

  def self.down
    rename_table :feedbacks, :delays
  end
end
