Dockingbay::Application.routes.draw do
  devise_for :users, controllers: {sessions: "sessions"}
  resources :containers, only: [:index, :show] do
    get :refresh
  end
  resources :images, only: :index
  resources :boxes
  root to: 'welcome#index'
end
