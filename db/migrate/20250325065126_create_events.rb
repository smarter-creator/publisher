class CreateEvents < ActiveRecord::Migration[7.1]
  def change
    create_table :events do |t|
      t.string :title, null: false
      t.datetime :start_datetime, null: false
      t.datetime :end_datetime, null: false
      t.string :recurrence_rule
      t.boolean :recurring, default: false 
      t.references :publisher, null: false, foreign_key: true

      t.timestamps
    end
  end
end
