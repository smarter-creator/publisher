class CreateEvents < ActiveRecord::Migration[7.2]
  def change
    create_table :events do |t|
      t.string :title
      t.datetime :start_datetime
      t.datetime :end_datetime
      t.string :recurrence
      t.references :publisher, null: false, foreign_key: true

      t.timestamps
    end
  end
end
