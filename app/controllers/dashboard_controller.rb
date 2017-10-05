class DashboardController < ApplicationController

  def index
    @statistics = StatisticsService.generate(current_user)
  end

end
