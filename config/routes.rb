Dockingbay::Application.routes.draw do
  devise_for :users, controllers: {sessions: "sessions"}
  resources :containers, only: [:index, :show]
  resources :images, only: :index
  resources :boxes
  root to: 'welcome#index'
end
