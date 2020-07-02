Rails.application.routes.draw do
  devise_for :users, skip: [:registrations]

  resource :users,
      only: [:edit, :update, :destroy],
      controller: 'devise/registrations',
      as: :user_registration do
    get 'cancel'
  end

  root to: 'cards#index'
  resources :cards, only: :index
  resources :board_stats, only: :index
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
