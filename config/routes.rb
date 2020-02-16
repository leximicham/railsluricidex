Rails.application.routes.draw do
  root to: 'root#index'
  resources :root
  namespace :api do
    namespace :v0 do
      resources :servers do
        collection do
          post :command
        end
      end
      resources :games
    end
  end
  resources :servers do
    collection do
      get :admin
      post :command
    end
    member do
      get :delete
    end
  end
  resources :games do
    collection do
      get :admin
      post :command
    end
    member do
      get :delete
    end
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
