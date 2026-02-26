class DashboardController < ApplicationController
  allow_unauthenticated_access

  def index
    if authenticated?
      @statistics = Statistics.for(Current.user)
    end
  end
end
