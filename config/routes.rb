Rails.application.routes.draw do
  root to: 'root#index'
  resources :root
  resources :servers
  resources :games
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
