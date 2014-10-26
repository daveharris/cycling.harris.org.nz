class CreateResults < ActiveRecord::Migration
  def change
    create_table :results do |t|
      t.references :user, index: true
      t.references :race, index: true
      t.integer :duration
      t.date :date
      t.text :comment
      t.text :timing_url
      t.text :strava_url

      t.timestamps
    end
  end
end
