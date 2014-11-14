Rails.application.routes.draw do
  resources :races
  resources :results do
    post :import, on: :collection
  end

  root to: 'dashboard#index'
end
