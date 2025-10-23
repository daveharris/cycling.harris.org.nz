class CreateResults < ActiveRecord::Migration[8.0]
  def change
    create_table :results do |t|
      t.references :user, null: false, foreign_key: true
      t.references :race, null: false, foreign_key: true
      t.integer :duration
      t.date :date
      t.text :comment
      t.string :url
      t.string :wind
      t.integer :fastest_duration
      t.integer :median_duration
      t.integer :position
      t.integer :finishers

      t.timestamps
    end
  end
end
