class CreatePublishers < ActiveRecord::Migration[7.1]
  def change
    create_table :publishers do |t|
      t.string :title, null: false
      t.text :description

      t.timestamps
    end
  end
end
