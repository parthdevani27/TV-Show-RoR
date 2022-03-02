class ChangeColumbFromShow < ActiveRecord::Migration[6.0]
  def change
     remove_column :shows, :start_time
     remove_column :shows, :end_time

    add_column :shows, :startTime, :datetime, null: false
    add_column :shows, :endTime, :datetime, null: false
  end
end
