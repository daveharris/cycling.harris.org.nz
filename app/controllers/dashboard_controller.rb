class DashboardController < ApplicationController

  def index
    @analytics = StatisticsService.generate(current_user)
  end

end
