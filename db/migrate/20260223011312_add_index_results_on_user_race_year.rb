class AddIndexResultsOnUserRaceYear < ActiveRecord::Migration[8.1]
  def change
    add_index :results,
      "user_id, race_id, strftime('%Y', date)",
      unique: true,
      where: "date IS NOT NULL",
      name: "index_results_on_user_race_year"
  end
end
