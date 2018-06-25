Rails.application.routes.draw do
  root to: 'root#index'
  get 'root/index'
  resources :tasks
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
