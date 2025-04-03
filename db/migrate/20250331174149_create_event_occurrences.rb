class CreateEventOccurrences < ActiveRecord::Migration[7.1]
  def change
    create_table :event_occurrences do |t|
      t.references :event, null: false, foreign_key: true
      t.datetime :occurrence_datetime

      t.timestamps
    end
  end
end
