class ChangeResultPositionDataType < ActiveRecord::Migration
  def change
    change_column :results, :timing_url, :string
    change_column :results, :strava_url, :string

    change_column :results, :position, :integer
    change_column :results, :finishers, :integer
  end
end
