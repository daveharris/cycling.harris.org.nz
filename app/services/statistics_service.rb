class StatisticsService

  def self.generate(user)
    @statistics = {
      this_year: {scope: Date.current},
      last_year: {scope: Date.current.last_year},
      total:     {scope: nil},
    }

    @statistics.each do |label, variables|
      results = Result.joins(:race)
      results = results.in_year(variables[:scope]) if variables[:scope].present?
      results = results.for_user(user) if user.present?

      @statistics[label][:results],
      @statistics[label][:distance],
      @statistics[label][:duration] = results.pluck('COUNT(races.id)',
                                                    'COALESCE(SUM(races.distance),   0)',
                                                    'COALESCE(SUM(results.duration), 0)'
                                                   ).first
    end
  end

end
