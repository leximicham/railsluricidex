Rails.application.routes.draw do
  get 'servers/index'
  get 'servers/delete'
  get 'servers/edit'
  get 'servers/new'
  get 'servers/show'
  root to: 'root#index'
  resources :root
  resources :games
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
