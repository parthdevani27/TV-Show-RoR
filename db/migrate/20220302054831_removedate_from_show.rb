class RemovedateFromShow < ActiveRecord::Migration[6.0]
  def change
    remove_column :shows, :date
    rename_column :shows, :startTime, :start_time
    rename_column :shows, :endTime, :end_time
  end
end
