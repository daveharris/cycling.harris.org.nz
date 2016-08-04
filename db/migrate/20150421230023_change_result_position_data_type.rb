class ChangeResultPositionDataType < ActiveRecord::Migration
  def change
    change_column :results, :timing_url, :string
    change_column :results, :strava_url, :string

    if defined?(ActiveRecord::ConnectionAdapters::PostgreSQLAdapter) && ActiveRecord::Base.retrieve_connection.kind_of?(ActiveRecord::ConnectionAdapters::PostgreSQLAdapter)
      execute 'ALTER TABLE results ALTER COLUMN position TYPE integer USING CAST(position as INTEGER);'
      execute 'ALTER TABLE results ALTER COLUMN finishers TYPE integer USING CAST(finishers as INTEGER);'
    else
      change_column :results, :position, :integer
      change_column :results, :finishers, :integer
    end

    Result.all.each { |r| r.update_attributes(position: 0) if r.position.nil? }
    Result.all.each { |r| r.update_attributes(finishers: 0) if r.finishers.nil? }
  end
end
