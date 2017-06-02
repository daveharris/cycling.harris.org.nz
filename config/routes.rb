Rails.application.routes.draw do
  root to: 'dashboard#index'

  resources :races

  resources :results do
    post :csv, :strava, :timing_team, on: :collection
    patch :timing_team_enrich, on: :member
  end

end
