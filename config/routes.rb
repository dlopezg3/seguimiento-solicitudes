Rails.application.routes.draw do
  get 'board_stats/index'
  devise_for :users
  root to: 'cards#index'
  resources :cards, only: :index
  resources :board_stats, only: :index
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
