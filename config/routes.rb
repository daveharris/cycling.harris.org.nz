Rails.application.routes.draw do
  resources :races
  resources :results do
    post :csv, :strava, :timing_team, on: :collection
  end

  root to: 'dashboard#index'
end
