Rails.application.routes.draw do
  resources :races
  resources :results do
    post :csv, :strava, on: :collection
  end

  root to: 'dashboard#index'
end
