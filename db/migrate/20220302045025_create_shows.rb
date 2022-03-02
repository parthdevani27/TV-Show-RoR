class CreateShows < ActiveRecord::Migration[6.0]
  def change
    create_table :shows do |t|
      t.string :name, null: false
      t.references :channel, null: false, foreign_key: true
      t.string :logo, null: true
      t.date :date, null: false
      t.time :startTime, null: false
      t.time :endTime, null: false
      t.text :description, null: true
      t.timestamps
    end
  end
end
