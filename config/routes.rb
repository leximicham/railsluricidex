Rails.application.routes.draw do
  get 'games/index'
  get 'games/show'
  get 'games/new'
  get 'games/edit'
  get 'games/delete'
  root to: 'root#index'
  get 'root/index'
  resources :tasks
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
