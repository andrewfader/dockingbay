Dockingbay::Application.routes.draw do
  resources :containers, only: [:index, :show]

  resources :images, only: :index

  root to: 'welcome#index'
end
