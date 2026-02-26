Statistics = Data.define(:result_count, :distance, :hours, :highest_position) do
  def self.for(user)
    new(
      result_count: Result.rider(user).count,
      distance: user.results.joins(:race).sum("races.distance"),
      hours: ActiveSupport::Duration.build(Result.rider(user).sum(:duration)).in_hours.floor,
      highest_position: Result.rider(user).maximum(:position)
    )
  end
end
