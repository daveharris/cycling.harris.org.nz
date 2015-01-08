class AddDetailsToResult < ActiveRecord::Migration
  def change
    change_table :results  do |t|
      t.string :wind
      t.integer :fastest_duration
      t.integer :median_duration
      t.string :position
      t.string :finishers
    end
  end
end
