class CreateRaces < ActiveRecord::Migration[8.0]
  def change
    create_table :races do |t|
      t.string :name
      t.integer :distance

      t.timestamps
    end
  end
end
