Rails.application.routes.draw do
  get 'sessions/new'
  get 'sessions/create'
  get 'signups/new'
  post 'sessions/create'
  get 'signups/create'
  post 'signups/create'
  root 'sessions#new'
  get 'tasks/index'
  resources :tasks
  resources :users
  resources :signups, only: [:new, :create, :show, :edit, :update]
  delete 'logout', to: 'sessions#destroy'
end
