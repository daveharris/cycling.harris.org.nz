class ChangeResultPositionDataType < ActiveRecord::Migration
  def change
    change_column :results, :timing_url, :string
    change_column :results, :strava_url, :string

    change_column :results, :position, :integer
    change_column :results, :finishers, :integer

    Result.all.each { |r| r.update_attributes(position: 0) if r.position.nil? }
    Result.all.each { |r| r.update_attributes(finishers: 0) if r.finishers.nil? }
  end
end
