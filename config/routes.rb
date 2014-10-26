Rails.application.routes.draw do
  resources :races
  resources :results

  root to: 'dashboard#index'
end
