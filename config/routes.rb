Rails.application.routes.draw do
  resources :races
  resources :results do
    post :csv, :strava, :timing_team, on: :collection
    patch :timing_team_enrich, on: :member
  end

  root to: 'dashboard#index'
end
